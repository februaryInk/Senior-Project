# Project README
---

This is a website that I constructed as a senior project over the course of the Fall 2014 and Winter 2015 semesters. I have continued to add to it as I learn better practices and techniques.

This readme will primarily consist of the coding style practices used in _this_ project. Given that it is being done for practice and self-entertainment, with very little likelihood of ever being contributed to by anyone else, I adhere to the style practices that I find to be most readable or the easiest to use. However, rest assured that when coding in a professional capacity, I like to take a "when in Rome" approach and do as the company, project, or (if without the example of the previous two) coding community at large does.

These style guides will likely see changes as I practice the rules dictated by them and learn better ways.

<br>

# General Style Guide
---

### Format Comments Consistently

I prefer to use multiple single-line comments over one large multi-line comment. I also put a space between the comment symbol(s) and the comment itself.

For title comments, used to mark off sections of code:
- Use all uppercase letters.
- Do not use sentence structure.
- Put a newline before and after the comment.

```
...
 
# SOME TITLE

...
```

For regular comments:
- Use all lowercase letters, unless it is very important to remember TODO something or make a NOTE.
- Use sentence structure (the exception being capitalization on account of the previous rule).
- Put it on the line before the pertinent code, if it relates to some specific parts.
- Do not use same-line comments. These comments increase code width, can be missed, look cluttered, and in some rare cases (.gitignore files) affect the output.

```
# do something. TODO: update this function once we know what "something" is.
def some_function
    do_something
end
```

### Use 4-Space Soft Tabs for Indentation

Never use hard tabs (that is, the tab character generated by the tab button) for indentation or alignment. Various text editors and IDEs might display tabs at different widths, resulting in inconsistent white space. Instead, use 4 spaces, called soft tabs, in place of any hard tabs. The Ruby convention is typically to use 2-space soft tabs to minimize character usage (consistent with the Ruby minimalist philosophy) and maximize line width for deeply nested code. However, 4-space tabs are easier to visually distinguish and align; therefore, I prefer them.

```
# bad - two spaces.
def some_function
  do_something
end

# good.
def some_function
    do_something
end
```

### Always End Files with a New Line

This is an old adage for text files, because it completes the structure of the previous line.

### Try to Limit Code Width to 100 Columns.

If there is no natural break point in the line, then wrapping should not be forced; but if there is, then the line should be wrapped to maintain a 100-character column width.

### When No More Reasonable Order Exists, Arrange Things Alphabetically

If there is no order suggested by the code itself, I strongly prefer to arrange snippets or keywords alphabetically when possible. This can be done for functions, style rules, library names, and so on. It generally makes snippets easier to locate, but it should of course defer in occasions where order affects the results, as with Rails validations.

```
gem( 'haml-rails' )
gem( 'pg' )
gem( 'sass-rails' )
gem( 'will_paginate' )
```

### Use Single Quotes Unless Using Double Serves a Purpose

```
a_string = 'Some thing.'
a_string_with_interpolation = "Some #{thing}."
```
<br>

# Git Commit Style Guide
---

To easily write commits longer than a single line, I keep a plain text file in the root of the working directory entitled "commit-message.txt". I record the commit message in this file, and run `$ git commit -F commit-message.txt` at the time of making the commit to use it as that commit's message.

I try to obey the following commit message rules:

**Subject**
- State the commit subject (the very first line) in imperative voice and omit articles.
- Make the commit subject a complete descriptive sentence.
- Try to limit the subject to at most 50 characters.
- Leave a single blank line between the subject and the body of the commit.

**Body**
- Present the body in two parts:
    - (Only when needed.) A short paragraph explaining the reason for the commit (when not self-evident), any necessary follow-up, and/or any lingering problems.
        - State the paragraph in first-person conversational tone.
    - A list of the actions taken during the commit.
        - State the list in past tense first-person active voice, but omit the sentence subject ("I"). Indent it by 4 spaces.
        - Put each action on its own line, but do not put blank lines between actions. This is to conserve vertical space in the Git log.
        - Always list any generators or installers, or any other unusual productive commands, that were run during the commit.
        - Use dashes ("-") as the bullet points for actions, dollar signs ("$") as the bullet points for commands, and stars ("*") as the bullet points for nested sub-actions.
        - If a list item takes up multiple lines, ensure that the first letter of the next line aligns with the first letter on the previous line, not with the bullet point.
- Limit line width to at most 75 characters so that the commit will display properly in a standard-width command prompt.

```
Do something to MyThing model.

Being unaware of what exactly the vague nature of "something" is, I cannot
say exactly what it is that this commit does.

    $ rails g migration rename_something_to_something_else
    - Updated the MyThing model.
        * Renamed something column.
        * Associated to SubSubSomething through SubSomething model.
```

<br>

# Sass Style Guide
---

Sass should be **predictable**, **reusable**, and **clean**.

- Use classes rather than ids, because id specificity is difficult to overcome. Reserve ids for jQuery selection.
- Do not add a tag qualifier on top of a class selector - for example, `a.affirmative` - except in cases where a class should behave differently based on the tag it is applied to. In general, the class will be good enough and the tag qualifier just uses additional processing time.
- Use nesting as minimally as possible. In particular, try to follow the Inception Rule and limit nesting depth to 4 levels. Class or id selectors should almost **NEVER** be nested; the styling gained by applying a class and espcially an id should be as predictable as possible, and modifying these selectors based on their location in the DOM counteracts this basic rule.
- Put each selector on its own line, with the last one followed by the opening curly brace.
- Put each rule on its own line.
- Put the closing curly brace on its own line.
- Only use Sass's `@extend` directive for related objects.
- Use ems and percentages over pixels...most of the time.

## File Names and Organization

When SCSS files are not linked on their own but rather are imported with Sass's `@import` directive in another file, their file name should be prepended with an underscore. This lets the precompiler know to not compile that particular file.

## Variables

I like to use variables for all colors and z-indices, each with their own dedicated files for easy lookup. When declaring color hex codes, I use all lowercase to avoid having to use caps lock or press and release shift multiple times.

```
// bad - uppercase hex codes.
$color-cornflower-blue: #6195ED;

// good.
$color-cornflower-blue: #6195ed;
```

To determine what to call a color, use a [color lookup website](http://chir.ag/projects/name-that-color/#6195ED) that provides names for over 1500 colors by their hex codes. If two colors are alike enough that they get the same name, then it is probable that they can be used as a single color, perhaps with Sass's `lighten` or `darken` functions to make up any difference. The color names are prepended with the word "color" to make it impossible to mistake the variable's purpose.

These color-by-name variables exist for easy reference and visualization of the colors being used. But in the code itself, it is easier to use color variable names that reference a color's function rather than its value so that if the color happens to change, it doesn't conflict with the given name. So whenever a color is used in the code, make a new variable with a name that describes its function and assign a color-by-name variable to it.

```
$color-cornflower-blue: #6195ed;

...

$color-link-text: $color-cornflower-blue;

...

a {
    color: $color-link-text;
    font-size: 1em;
    text-decoration: none;
}
```

All of these color-by-function variables can go in their own file as well, making colors easier to reference or replace.

## Class Names

The Sass naming conventions followed in this project are based on a methodology called BEVM, a variation (heh) of the Block Element Modifier (BEM) method. BEVM stands for Block Element _Variation_ Modifier, and it allows for a slightly more categorical approach to class naming than vanilla BEM. The following rules detail my use of BEVM.

### Rule 1: Objects

The key to flexible modular CSS (or SCSS, as the case is) is to regard the HTML structures to which styles are applied as reusable, modifiable objects. An object is a group of elements that can be regarded as self-contained or which are placed on the page as a whole, such as headers, links, or tables. Give objects descriptive names that consist of, or at least contain, a noun.

```
.link {
    background-color: $color-link;
    color: $color-link-text;
    display: block;
    margin: 0.25em 0;
    padding: 0.5em;
    
    &:active {
        background-color: $color-link-active;
    }
    
    &:hover {
        background-color: $color-link-hover;
    }
}
```

### Rule 2: Elements, or Descendants of Objects

Try to not nest child elements within object selectors (espcially using class or id selectors, as asserted previously). Instead, append the parent name as a prefix if the child element can't be regarded as a reusable object in its own right.

```
.link {
    background-color: $color-link;
    color: $color-link-text;
    display: block;
    margin: 0.25em 0;
    padding: 0.5em;
    
    &:active {
        background-color: $color-link-active;
    }
    
    &:hover {
        background-color: $color-link-hover;
    }
}

.link__icon {
    float: left;
    height: 2em;
    width: 2em;
}
```

The exception to this is if the parent object exists as a container for a collection of similar children; in that case, the parent can be named as the plural of the children.

```
.friend {
    float: left;
    margin: 1em;
    text-align: center;
    width: 10em;
}

.friends {
    background-color: $friends-color;
    width: 100%;
}
```

### Rule 3: Variations

Two objects may serve similar functions on the page but be entirely unrelated in terms of stylistic rules. Name them with the same object name (noun) followed by two dashes and a unique one- or at most two-word descriptor (adjective). The descriptor is placed after the object name so that when sorted within the page, rules for these similar objects will tend to be close together.

```
.sidebar--left {
    float: left;
    width: 384px;
}

.sidebar--right {
    float: right;
    width: 256px;
}
```

### Rule 4: Scoped Modifiers

On the other hand, there may be instances where two objects are similar in purpose and share some properties, but not all. In that case, we can introduce scoped modifier classes in a way that is analogous to subclassing in object-oriented languages. Most object-oriented programming languages have a way of subclassing objects such that the subclass becomes a "type" of the superclass. It inherits the behaviors of the superclass while typically adding some behaviors of its own. This same principle can be applied to SCSS. We can, for example, make a small logo inherit all the properties of a general logo while adding its own additional properties. This can be accomplished by using SCSS's ampersand operator with a class. (This is similar to the functionality of an `@extend`, but isn't shared between selectors.)

Local modifiers should have adjective names, prepended with a single dash. The nesting is used to ensure that the modifiers apply to only one object and no others.

```
.logo {
    background-image: image_url('logo.svg');
    background-repeat: no-repeat;
    background-size: contain;
    display: inline-block;
    
    &.-big {
        height: 96px;
        width: 282px;
    }

    &.-small {
        height: 64px;
        width: 188px;
    }
}
```

The classes `.-small` and `.-big` modifiers are scoped to the `logo` class, and must always be used in conjunction with it to be effective.

```
= link_to( '', root_path, { :class => 'logo -small' } )
```

### Rule 5: Global Modifiers

In some cases, though, it may be appropriate to create a global modifier that can be used with any object. These modifiers can be used to effect small adjustments on elements that either don't have their own class, or that have a class that shouldn't be altered directly because it is used elsewhere as is. However, if more than 2 global modifiers are applied to a single element, it may be better to give the element its own class. These global modifiers are not for building up a style from scratch; they are for tweaking elements that behave just a little bit different from the rest.

```
.green { 
    background-color: green;
}

.push { 
    margine-bottom: 2em;
}
```

Modifier names should be short descriptors, preferably a single adjective where possible.

### Rule 6: JavaScript Selectors

When a class or id is being used by JavaScript as a selector, make it obvious by prepending `js` to the selector. Do not use JavaScript selector classes for styling; they should be as de-coupled as possible from the element's styles and should briefly describe the element's JavaScript meaning.

```
%ul
  %li
    = link_to( 'Home', root_path )
  %li
    = link_to( 'About', about_path )
  %li.dropdown.js-dropdown
    %span.dropdown__label
      My Account
    %ul.dropdown__menu.js-dropdown-menu
      %li
        = link_to( 'My Profile', profile_path )
      %li
        = link_to( 'Sign Out' sign_out_path )
```

### Summary

The rules described in the previous sections are summarized in the table shown here.

| Rule                | Class Naming Convention               | Grammatical Format                  | Brief Description                                               |
|---------------------|---------------------------------------|-------------------------------------|-----------------------------------------------------------------|
| Object              | Use a descriptive noun name.          | noun                                | Any group of elements capable of standing alone.                |
| Descendant          | Prepend the Object ancestor's name.   | noun__noun                          | An Object descendant that can't exist on its own.               |
| Scoped Modifier     | Prepended a dash and nest the rule.   | -adjective                          | A modification applicable to a single Object.                   |
| Variation           | Append a descriptor to differentiate. | --adjective                         | A variation of multiple similar but unrelated Objects/Elements. |
| Global Modifier     | Describe the modification's effect.   | adjective, or property name + value | A modification applicable to many elements.                     |
| JavaScript Selector | Describe the functional meaning.      | js- + brief description             | A hook for JavaScript purposes.                                 |

## Inter-Selector Organization

- List selectors from weakest (least specificity) to strongest (highest specificity). This alludes to CSS override order: if the same rule under the same selector is declared multiple times, the last instance overrides all those that came before.
- When multiple selectors have the same strength (for example, all class name selectors), organize them alphabetically.
- Put a new line between each new selector.

## Intra-Selector Organization

### Put 1 Space between the Selector Name and the Curly Brace.

This little bit of white space makes the curly braces easier to pick out and is cleaner-looking.

### Put 1 Space after Colons

Again, the white space makes the code cleaner-looking and makes it easier to differentiate rules and their set values.

### Don't Use Single-Line Declarations

Even if a selector only has a single rule, I leave them multi-line. This keeps all decorations consistent with each other and makes it simpler to add additional rules later, if they are ever needed.

```
// bad - everything on one line.
.padded-2em { padding: 2em; }

// good.
.padded-2em {
    padding: 2em;
}
```

### Rule Organization

Having a plan for rule organization makes them always easy to find. I like to use the following order for the different categories of rules.

1. Extends (`@extend`): Alphabetized
2. Mixins (`@include`): Alphabetized
3. CSS rules: Alphabetized
4. Pseudo-classes (`&:`): Alphabetized
5. Miscellaneous Parent-modifying rules (`&.`, `&#`): Alphabetized
6. Pseudo-elements (`&::`): Alphabetized
7. Nested selectors: By specificity, then alphabetized

Mixins and extends come first because it is nice to know straight off that the selector inherits or has the potential to inherit a whole other set of rules. After that, the order is generally dictated by how directly the rules will affect the selector element.

# HAML Style Guide

### Place Individual Elements, Including Text Nodes, on Their Own Lines

### Indent Child Objects 1 Step Past Their Parents

### Do Not Omit the `div` Tag Declarations

It is a common practice in HAML to leave off the tag declaration for `div`s and let the element default to a `div`. This feature was added in because `div`s are so common.

```
.content
    Hello, World!
```

However, I prefer to keep the `div`s explicit. Omitting the tag implies that a `div` is a nothing element, empty of any identity, when it is not - or at the least, no more so than a `span`. Both are basic elements, with distinct properties and uses. Additionally, the omission makes it more difficult to visually identify the tag and makes tag declaration inconsistent.

# Ruby Style Guide

I am particularly aware that I do not, in this particular project, follow the conventional style practices for Ruby on Rails. This is because I think that a few Rails style practices, such as the omission of parenthesis for most Rails DSL functions, are unnecessarily inaccessible to Rails new-comers or result in semi-ambiguous situations.

## Routes
