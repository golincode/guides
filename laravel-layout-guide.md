Laravel Layout Guide
===================

## General Notes

Laravel’s guide is similar to PSR, but with these key differences:

- Class braces `{` appear on the same line as the class
- Function and control braces `{` appear on the next line ([Allman style](http://en.wikipedia.org/wiki/Indent_style#Allman_style))
- Use tabs rather than spaces to indent
- Namespace declarations should be on the same line as `<?php`
- Interface and Trait names are suffixed with `Interface` (`FooInterface`) and `Trait` (`FooTrait`) respectively

## Controllers

### Example

See an [example controller](https://github.com/wearearchitect/guides/blob/master/laravel-guide-controller.php).

## Models

In an effort to standardise how we all layout our Models, below is a suggested format.

### Order

The recommended order is as such:

- Class Attributes
- Constructors
- [Relationships](http://bit.ly/1kSnB2h)
- [Model Events](http://bit.ly/1kcQpfQ)
- [Accessors & Mutators](http://bit.ly/UnWpOc)
- [Date Mutators](http://bit.ly/1uJRMup)
- [Query Scopes](http://bit.ly/SrfKMz)
- Custom Methods
- Magic Methods

### Separation

Sections are separated like thus:

    /**
     * ! Section Name
     */

### Example

See an [example model](https://github.com/wearearchitect/guides/blob/master/laravel-guide-model.php).

### Comments

Comment everything or you'll die a horrible, horrible death!!
