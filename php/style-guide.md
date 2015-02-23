# PHP Style Guide (PSRchitect)

- [General / Syntax](#general--syntax)
- [Cases](#cases)
- [Names](#names)
  - [Variables](#variables)
  - [Classes](#classes)
  - [Functions and Methods](#functions-and-methods)
  - [Interfaces and Traits](#interfaces-and-traits)
- [Namespaces](#namespaces)
- [Structure](#structure)
- [Doc Blocks](#doc-blocks)
- [Principles](#principles)
  - [Single Responsibility](#single-responsibility)

## General / Syntax

- Leave a blank line at the end of files
- Remove trailing whitespace from all lines
- Indent with tabs, not spaces
- Use square bracket array syntax
  - `[1, 2, 3]` - yes
  - `array(1, 2, 3)` - no
- When using multi-line arrays, always end each line with a comma (including the final line)
- Opening brackets `{` go on a new line for everything, apart from:
  - Class definitions, which have the opening bracket `{` on the same line
- Namespace declarations should be on the opening line, with `<?php`
- Keep lines short and concise: 80 - 130 lines is a soft limit
- Use `!=` instead of `<>`
- If parentheses are not needed in a constructor, don't use them:
  - good: `$user = new User;`
  - bad: `$user = new User();`
- Limit injected dependancies to five per class, but aim for three or fewer - five is the *upper limit*.
- Use no more than two levels of indentation within methods.
- If the code block in an if clause returns or throws something, do not use the `else` clause - simply carry on with the regular code flow.

## Cases

- Variables use lowerCamelCase - `$inputData`
- Functions use snake_case - `is_it_lunch_time()`
- Classes use UpperCamelCase - `new BigAssTank`
- Methods use lowerCamelCase - `$bigTank->fireAt( $jonny )`
- Constants use SNAKE_CAPS - `$job == Job::FRONT_END_DEV`

## Names

- Be as explicit as possible. If it is a class / method name, for example, its responsibility (see Single Responsitbility Principle) should be obvious from the name.
- Avoid abbreviating class and variable names.

### Variables

#### Types

- Use plurals for arrays and collections (rather than appending `array`), and singular for everything else
  - `$users` is an array of users
  - `$rocket` is a single rocket
- If the variable is a boolean, prefix with `is`, `has` (preferred), or be adjectival. It should also be a positive name
  - `$isStarred` - good
  - `$hasPosts` - good
  - `$active` - good
  - `$inactive` - bad
- If an object is in scope with objects of other types, suffix or include a relevant part of the object's class name
  - `$relatedDocument` - good
  - `$related` - bad

#### Content

- Variable names should be short yet meaningful.
- They should indicate to the casual observer the intent of its use
- They should describe the content of the variable, rather than any meta information about it or its scope ( try to avoid words like `tmp`, `result`, `arguments`, `data`, `array`, `retval`, etc. )

#### Iterators

- `$i`, or a simple variant is acceptable as an iterator
- If it is several nested loops, use something like `$xi` for the top level, `$xii` for the second level, `$xiii`, `$xiv` etc

### Classes

- There are two parts to a class name, the namespace and the actual name
  - The namespace should describe the class scope
  - The class name should describe its responsibility
- Suffix subclass names with the base class, or design pattern name
  - `UserController` is a subclass of `Controller`
  - `ViewManager` uses the manager design pattern

### Functions and Methods

- Actionable functions and methods should be verbs in the [imperative](http://en.wikipedia.org/wiki/Imperative_mood)
  - `$user->save()`
  - `$table->render()`
  - `$person->eat( $pie )`
- Methods that get data should [reflect the data they return](#types)
  - `$person->isTallerThan( $otherPerson )` - boolean
  - `$breakfast->sausages()` - array
- Getters and setters should be `getProperty` and `setProperty`
- Functions are for helper functions that have no logical place in the codebase

### Interfaces and Traits

- Interface and Trait names are suffixed with `Interface` (`FistInterface`) and `Trait` (`ShortPersonTrait`) respectively

## Namespaces

- At the top of the file, list and `use` **all** the dependancies of the class, in three sections separated by a blank line
- There should, then, be no classes used that are not listed here
- The three sections:
  - Global classes and aliases (classes in the global namespace)
    - `use App;`
  - Library classes (anything in `vendor/` folder)
    - `use Carbon\Carbon;`
    - `use Symfony\Component\HttpFoundation\JsonResponse as Response;`
  - Project classes (anything in your project's namespace)
    - `use MyApp\Auth\User;`
- The quantity of these declarations can be a good indicator of [too many responsibilities](#single-responsibility)
- When a string of the fully namespaced class name is required, use the `class` magic constant rather than a custom string
  - `$classname = 'App\Auth\User';` - bad
  - `$classname = User::class;` - good

## Structure

Sections within a class or file are separated with an exclamation mark, followed by the section title, like so:

    // ! Section One
    ...
    // ! Section Two

## Indentation

### Method Chaining

When method chaining, indent **one** level per different object.

```php
$query->where( 'age', '>', '18' )     // returns query object
    ->andWhere( 'registered', true )  // returns query object
    ->orderBy( 'lastname' )           // returns query object
    ->get()                           // returns results object
        ->map( $mapFunction );        // returns results object
```

## Doc Blocks

Docblocks must exist on **every** method, function and property.

They should contain a short description (ie. should not make the line exceed 80 characters).

### Properties

A description, type, and access specifier for any property.

```php
class Thing {

  /**
   * Short Description
   *
   * @access public
   * @var \App\ParentCollection
   */
  public $parents;

}
```

### Functions & Methods

Functions and methods should contain at least
- a short description
- a summary of input arguments
- a return type

The short description should ideally describe what the function does - without using the word "and". This is a basic test for [single responsibility](#single-responsibility).
It should describe **what** the function does, not **how** it does it - ie. if it calls other functions or methods, it does not need to describe what they do.

It should be in the [imperative mood](http://en.wikipedia.org/wiki/Imperative_mood) - describing what the function does in plain english:
- Imperative (yes): `Convert User model into array`
- Not Imperative (no): `Converts user to array`

If an input argument is an object, be specific about what the object is. Use the full class name, with a `\` dereferencer at the start.

```php
/**
 * Read the contents of the file at the given path
 *
 * Details about optional arguments, etc.
 *
 * @param  \App\Support\File    $file
 * @param  array                $options
 * @param  boolean              $delete
 * @return void
 */
public function readFile( File $file, $options = [], $delete = false )
```

## Principles

### Single Responsibility

- Keep classes and methods, to one responsibility.
- Try to describe the class or method without using the word 'and'
