<?php namespace App\Module;

use Auth;

use Carbon\Carbon as Carbon;

use App\I18n\Translatable as Eloquent;
use App\User\User;

class Module extends Eloquent {

	/**
	 * ! Class Attributes
	 */

	/**
	 * The date column to use for unpublishing
	 *
	 * @access protected
	 * @var array
	 */
	protected $dates = ['published_at'];

	/**
	 * Holds an array of any custom attributes we're
	 * setting in the constructor.
	 *
	 * @access protected
	 * @var array
	 */
	protected $attributes = ['published_at'];

	/**
	 * ! Constructors
	 */

	/**
	 * Module constructor.
	 * We're setting the published_at to default
	 * to now as it has sort of been depreciated but
	 * is still slightly used. Need to remove.
	 *
	 * @access  public
	 * @param   array $attributes
	 *
	 * @return  void
	 */
	public function __construct( array $attributes = array() )
	{
		$this->setRawAttributes([
									'published_at' => Carbon::now(),
								], true);

		parent::__construct($attributes);
	}

	/**
	 * ! Relationships
	 */

	/**
	 * The Module's parent Study
	 *
	 * @access public
	 * @author Stef Horner (shorner@wearearchitect.com)
	 *
	 * @return BelongsTo
	 */
	public function parent()
	{
		return $this->belongsTo('Study\Study', 'study_id');
	}

	/**
	 * Each Module can have many LocalModules (translations)
	 *
	 * @access public
	 *
	 * @return LocalModule
	 */
	public function localModules()
	{
		return $this->hasOne('Module\LocalModule');
	}

	/**
	 * The Module's Lessons
	 *
	 * @access public
	 * @author Stef Horner       (shorner@wearearchitect.com)
	 *
	 * @return HasMany
	 */
	public function lessons()
	{
		return $this->hasMany('Lesson\Lesson')->orderBy('order');
	}

	/**
	 * The Module's Lessons Translations
	 *
	 * @access public
	 *
	 * @return HasManyThrough
	 */
	public function lessonTranslations()
	{
		return $this->hasManyThrough('Lesson\LocalLesson', 'Lesson\Lesson');
	}

	/**
	 * Returns the Module's first Lesson
	 *
	 * @access public
	 * @return Lesson
	 */
	public function toStart()
	{
		return $this->orderBy('order')->first()->lessons->first();
	}

	/**
	 * The Module's Lesson's Steps
	 *
	 * @access public
	 *
	 * @return HasManyThrough
	 */
	public function steps()
	{
		return $this->hasManyThrough('Step\Step', 'Lesson\Lesson');
	}

	/**
	 * Returns Progress objects for the Module && User
	 *
	 * @access public
	 *
	 * @return HasManyThrough
	 */
	public function progress( User $user = null )
	{
		if ( is_null($user) )
			$user = Auth::user();

		return $this->hasManyThrough('Module\Progress', 'Lesson\Lesson', 'module_id', 'lesson_id')
			->where('user_id', $user->id);
	}

	/**
	 * ! Model Events
	 */

	/**
	 * When deleting a Module make sure delete is
	 * cascaded onto all it's LocalModules
	 *
	 * @access public
	 *
	 * @return boolean
	 */
	public function delete()
	{
		$this->translations()->delete();

		return parent::delete();
	}

	/**
	 * ! Accessors & Mutators
	 */

	/**
	 * Calculate the progress
	 *
	 * @access public
	 * @author Stef Horner       (shorner@wearearchitect.com)
	 * @return float
	 */
	public function getTotalProgressAttribute( User $user = null )
	{
		if ( is_null($user) )
			$user = Auth::user();

		$completed = $this->progress( $user )
										->count();

		if ( 0 == $completed )
			return 0;

		return $completed / $this->lessons()->count() * 100;
	}

	/**
	 * ! Query Scopes
	 */

	/**
	 * Limit the query to Modules that have
	 * LocalModules (translations) that are visible
	 *
	 * @access public
	 * @param  QueryBuilder $query
	 *
	 * @return QueryBuilder
	 */
	public function scopeVisible( $query )
	{
		if ( Auth::check() && ! Auth::user()->can('manage-modules') )
			$query->whereHas( 'localModules', function($q){
				$q->whereNotNull('published_at');
				$q->where('published_at', '<=', \DB::raw('NOW()'));
			});

		return $query;
	}

	/**
	 * Returns a where statmente that check if the module
	 * contains any lessons that have been started.
	 *
	 * @access public
	 * @param  QueryBuilder $query
	 *
	 * @return QueryBuilder
	*/
	public function scopeWhereStarted( $query )
	{
		return $query->whereHas('progress', function($q)
		{
			$q->where('user_id', Auth::user()->id);
		});
	}

	/**
	 * Returns a where statmente that check if the module
	 * contains any lessons tht have NOT been started.
	 *
	 * @access public
	 * @param  QueryBuilder $query
	 *
	 * @return QueryBuilder
	 */
	public function scopeWhereNotStarted( $query )
	{
		return $query->whereHas('progress', function($q)
		{
			$q->where('user_id', Auth::user()->id);
		}, '=', 0);
	}

	/**
	 * Returns a where statmente that check if the module
	 * contains any lessons tht have NOT been started.
	 *
	 * @access public
	 * @param  QueryBuilder $query
	 *
	 * @return QueryBuilder
	*/
	public function scopeWhereNotCompleted( $query )
	{
		return $query->whereHas('progress', function($q)
		{
			$q->where('user_id', Auth::user()->id);
		}, '<', $this->lessons->count());
	}

	/**
	 * Returns a where statmente that check if the module
	 * contains any lessons tht have NOT been started.
	 *
	 * @access public
	 * @param  QueryBuilder $query
	 *
	 * @return QueryBuilder
	*/
	public function scopeWhereCompleted( $query )
	{
		return $query->whereHas('progress', function($q)
		{
			$q->where('user_id', Auth::user()->id);
		}, '=', $this->lessons->count());

	}

	/**
	 * ! Custom Methods
	 */

	/**
	 * Returns whether the current User has started the Module
	 * already or not.
	 *
	 * @access public
	 *
	 * @return boolean
	 */
	public function hasStarted()
	{
		return $this->progress()->count() > 0;
	}

	/**
	 * ! Magic Methods
	 */

	/**
	 * Allow this class to be cloned.
	 * Unset the ID and exists.
	 * Used in the content duplicator
	 *
	 * @access public
	 *
	 * @return void
	 */
	public function __clone()
	{
		// Remove the associated ID
		$this->id = null;

		// Show that the entry doesn't currently exist
		$this->exists = false;

		// Wipe the original values
		$this->original = [];
	}

}
