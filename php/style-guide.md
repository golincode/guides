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
- [Principles](#principles)
  - [Single Responsibility](#single-responsibility)

## General / Syntax

- Leave a blank line at the end of files
- Remove trailing whitespace from all lines
- Indent with tabs, not spaces
- Use square bracket array syntax
  - `[1, 2, 3]` - yes
  - `array(1, 2, 3)` - no
- Opening brackets `{` go on a new line for everything, apart from…
- Class definitions have the opening bracket `{` on the same line
- Namespace declarations should be on the opening line, with `<?php`
- Keep lines short and concise: 80 - 130 lines is a soft limit
- Use `!=` instead of `<>`

## Cases

- Variables use lowerCamelCase - `$inputData`
- Functions use snake_case - `is_it_lunch_time()`
- Classes use UpperCamelCase - `new BigAssTank`
- Methods use lowerCamelCase - `$bigTank->fireAt( $jonny )`
- Constants use SNAKE_CAPS - `$job == Job::FRONT_END_DEV`

## Names

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

## Principles

### Single Responsibility

- Keep classes and methods, to one responsibility.
- Try should be able to describe the class or method without using the word 'and'
