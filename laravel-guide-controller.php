<?php namespace App\Guide;

use Redirect;
use Response;
use View;

use App\Camels\CamelRepository;
use App\Mammals\MammalTrait;

class CamelCaseController extends Controller {

	use MammalTrait;

	public function __construct(CamelRepository $repo)
	{
		$this->repo = $repo;
	}

	/**
	 * Store a camel
	 *
	 * @access public
	 * @return obj Redirect to list of camels
	 */
	public function redirectToLogin()
	{
		$this->repo->storeCamel();

		return Redirect::route('camel.index');
	}

}
