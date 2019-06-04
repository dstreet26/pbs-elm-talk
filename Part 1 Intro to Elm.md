class: middle, center

# Elm at PBS

---

## Part 1 Elm introduction and syntax

## .faded[Part 2 Lessons learned from Otter and Tizen]

## .faded[Part 3 Elm-GA prototype thoughts]


### Better Elm Guides:

- https://guide.elm-lang.org
- https://elmprogramming.com
- https://pragmaticstudio.com/tutorials/what-is-elm

---

## Define Elm

Elm is a functional programming language targeting web development.

It has an ML-like syntax

- [C-like](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages): (C, C++, Swift, Java, C#, Javascript, PHP, Perl)
- [ML-like](https://en.wikipedia.org/wiki/Category:ML_programming_language_family): (StandardML, Haskell, Purescript, F#, OCaml, Reason)
- [Lisp-like](https://en.wikipedia.org/wiki/Category:Lisp_programming_language_family): (Clojure, Common Lisp, Scheme)


### [Elm Guide](https://guide.elm-lang.org/): "Elm has a very strong emphasis on **simplicity**, **ease-of-use**, and **quality tooling**."


???

Elm is a functional reactive programming language that compiles to (client-side) JavaScript.


What does it mean to be functional?

- First Class Functions
- Immutability
- Recursion
- Expression-Oriented Programming
- Currying
- Lazy Evaluation\*
- Algebraic Data Types
- Other topics (Higher Kinded Types, Existential Types)

Elm is statically typed, meaning that the compiler catches most errors immediately and provides a clear and understandable error message. 

It brings the safety and stability of functional programing to front-end development.

"Elm has a very strong emphasis on **simplicity**, **ease-of-use**, and **quality tooling**."

Let's break that apart

---


## Simplicity

- Everything you write is a pure function or a value
- Everything must have a type
- Functions are pure: they must return a type
- All values ​​are static
- There is only one way to import functionality (vs. AMD/CommonJS/UMD)
- Fewer keywords to learn

#### Elm keywords

alias, as, case, command, effect, else, exposing, if, import, in, infix, left, let, module, non, of, port, right, subscription, then, type, where

#### JS keywords

Bold words are new in ECMAScript 5 and 6.

abstract, arguments, **await**, boolean, break, byte, case, catch, char, **class**, const, continue, debugger, default, delete, do, double, else, **enum**, eval, **export**, **extends**, false, final, finally, float, for, function, goto, if, implements, **import**, in, instanceof, int, interface, **let**, long, native, new, null, package, private, protected, public, return, short, static, **super**, switch, synchronized, this, throw, throws, transient, true, try, typeof, var, void, volatile, while, with, yield

---
## Ease-Of-Use

Elm-reactor is built in. It spins up a live-rebuild server with a time-traveling debugger.

The compiler just produces javascript, so integrating it is straightforward.

[Programmer-friendly error messages](https://www.google.com/search?q=elm+compiler+warning+examples&tbm=isch)

---
## Quality Tooling


### Canonical formatter

All elm code looks the same and it looks good.

Formatter is very fast.

---
## Quality Tooling

### Canonical package manager

Packages can only use Elm code.

This means a break from the 800k+ npm modules out there but it provides guarantees that would otherwise be impossible like:

- Tree-shaking
- Enforced semantic versioning
- Fewer security concerns ([NPM Advisories](https://www.npmjs.com/advisories))

#### Enforced Semantic Versioning

Major: "You will have to change your software."

Minor: "There are API changes which you might want to use."

Micro: "The API hasn't changed."

???
#### Security

If the API of a library changes, it will automatically get a major version bump. This solves an entire class of dependency problems.


---

## Quality Tooling

### [Elm-Analyse](https://github.com/stil4m/elm-analyse)

### [JSON-To-Elm](https://json-to-elm-019.netlify.com/)

### [HTML-To-Elm](https://mbylstra.github.io/html-to-elm/)

### [Ellie](https://ellie-app.com/new)

### [Elm Search](https://klaftertief.github.io/elm-search/)

---

## Quality Tooling

### VSC

[Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=sbrink.elm)

- Syntax highlighting
- Intellisense
- Package discovery/documentation/installation)
- Jump to error

---
# How do I install it?

- From the [Official Guide](https://guide.elm-lang.org/install.html)
- From a [Github release page](https://github.com/elm/compiler/releases/tag/0.19.0)
- From npm:
    - `npm i -g elm`
    - (or `npm i -D elm` for per-project install)

---
# How do I get it into a browser?
```sh
elm make Main.elm --output=out.js
```

In a realworld package.json:

```json
"build:elm": "elm make src/elm/Main.elm --optimize --output=build/js/main_compiled.js"
```

In some html:

```html
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  </head>
  <body>
    <div id="app"></div>
  </body>
  <script src="out.js"></script>
  <script>
    const elmApp = Elm.Main.init({
      node: document.getElementById('app')
    })
  </script>
</html>
```

---

# Bonus: Embed as React-component

```javascript
import Elm from 'react-elm-components'
import { MyApp } from 'out.js'

function render() {
  return <Elm src={MyApp} />
}
```

---

#### First-class currying and partial application ([Chris Krycho](https://www.chriskrycho.com/2017/why-elm-instead-of-typescript.html))



##### ES5:

```javascript
var add = function add(a, b) {
  return a + b
}

var add2 = function add2(c) {
  return add(2, c)
}

var five = add2(3)
```

##### ES6:

```javascript
const add = (a, b) => a + b
const add2 = c => add(2, c)
const five = add2(3)
```

##### Elm:

```elm
add a b = a + b
add2 = add 2
five = add2 3
```


---

# let-in, extra annotations
   

```elm
episodeMetaData episode =
    let
        ordinals = formatOrdinals episode
        duration = formatDuration episode.duration
    in
        ordinals ++ "|" ++ duration
```


```elm
episodeMetaData episode =
    let
        ordinals : String
        ordinals = formatOrdinals episode
        
        duration : String
        duration = formatDuration episode.duration
    in
        ordinals ++ "|" ++ duration
```

---


# Learn X in Y minutes

https://learnxinyminutes.com/docs/elm/

???
paste in **parts of** talk_repl_yminutes.elm

Elm records vs. JS objects

difference between IF statement and IF expression

Purity

type annotations

Enums + Tagged Unions

Ports

---


# TEA

The Elm Architecture is: Model-Update-View + Elm Runtime

### Architecture

Model - The current state of the app

Update - A pure function that takes the current state and a Message and returns a new state; the only place that "changes" data

View - A pure function that takes the current state and returns HTML to be rendered

### In-Code

Model - The definition of the data that you need

Update - Where you handle your actions

View - Where you write your divs and classes


---
# TEA

## Familiarity

Every Elm project you see in the wild has this, it makes orientation very easy

Debugging application logic is straightforward because there is only one place that data is "updated"

Getting started on a task is straightforward:

- Does something look wrong? Start with the View

- Adding a new feature? Start by adding types to the Model

- Something not behaving correctly? Start by looking at how the Msg is handled in the update function

---

# TEA

[Inspired Redux!](https://redux.js.org/introduction/prior-art)

(Un-related: [MVC vs. MVVM](https://stackoverflow.com/questions/667781/what-is-the-difference-between-mvc-and-mvvm))




---

### Quick React code Comparison

https://ohanhi.com/react-typescript-vs-elm.html

---

```javascript
import * as React from 'react'
import * as Redux from 'redux'
// import Action and State from someplace
import * as Actions from './actions.ts'
import { State } from './reducer.ts'

interface DispatchProps {
  onNameChanged: (text: string) => void
}

type Props = State & DispatchProps

const MyComponent = (props: Props) => (
  <div>
    <input
      onInput={(event: any) => props.onNameChanged(event.target.value)}
      value={props.yourName}
    />
    <h1>Hello, {props.yourName}!</h1>
  </div>
)

const mapStateToProps = (state: State): State => state

const mapDispatchToProps = (dispatch: Redux.Dispatch<Actions.Action>): DispatchProps => ({
  onNameChanged: (text: string) => dispatch(Actions.onNameChanged(text)),
})

export default connect<State, DispatchProps>(
  mapStateToProps,
  mapDispatchToProps
)(MyComponent)
```



---

```elm
module View exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
-- import Model and Msg from someplace
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput NameChanged, value model.yourName ] []
        , h1 [] [ text model.yourName ]
        ]
```



---

## Standard Library Batteries

- [Basics](https://package.elm-lang.org/packages/elm/core/latest/Basics)
- [List](https://package.elm-lang.org/packages/elm/core/latest/List)
- [String](https://package.elm-lang.org/packages/elm/core/latest/String)
- [Time](https://package.elm-lang.org/packages/elm/time/latest/Time)
- [Dict](https://package.elm-lang.org/packages/elm/core/latest/Dict)
- [Set](https://package.elm-lang.org/packages/elm/core/latest/Set)
- More!

## Some favorite Libraries

- [NoRedInk/elm-json-decode-pipeline](https://package.elm-lang.org/packages/NoRedInk/elm-json-decode-pipeline/latest/)
- [danyx23/elm-uuid](https://package.elm-lang.org/packages/danyx23/elm-uuid/latest/)
- [elm/time](https://package.elm-lang.org/packages/elm/time/latest/)
- [elm-community/list-extra](https://package.elm-lang.org/packages/elm-community/list-extra/latest/)
- [elm-community/string-extra](https://package.elm-lang.org/packages/elm-community/string-extra/latest/)
- [mhoare/elm-stack](https://package.elm-lang.org/packages/mhoare/elm-stack/latest/)
- [wernerdegroot/listzipper](https://package.elm-lang.org/packages/wernerdegroot/listzipper/latest/)


???

Ask people what looks interesting

Look at String-Extra

Remember that all libraries are 100% Elm

---

## Community

You can Google and/or Youtube for:

awesome-Elm, Elm weekly, Elm courses, Elm books, Elm slack, Elm subreddit, Elm stackoverflow



### Recommended Reading

Realworld project implementation by Richard Feldman: https://github.com/rtfeldman/Elm-spa-example

https://github.com/isRuslan/awesome-Elm

[Why We Still Choose (and Recommend) Elm in 2019?](https://github.com/dwyl/learn-elm/issues/129)

---

### Community

#### Companies using Elm

Github list: https://github.com/jah2488/Elm-companies

More well-known companies:
- Microsoft (https://github.com/Microsoft/Elm-json-tree-view)
- IBM (https://discourse.Elm-lang.org/t/ibm-releases-Elm-powered-app/2364)
- Ableton (makers of Ableton Live) (https://learningmusic.ableton.com/)
- Adobe

#### Youtube

[Midwest.io 2014 - Demystifying Haskell - Andrew Rademacher](https://www.youtube.com/watch?v=apBWkBDVlow)

[Evan Czaplicki - Convergent Evolution](https://www.youtube.com/watch?v=jl1tGiUiTtI)

["Making Impossible States Impossible" by Richard Feldman](https://www.youtube.com/watch?v=IcgmSRJHu_8)

[Elm Europe 2017 - Evan Czaplicki - The life of a file](https://www.youtube.com/watch?v=XpDsk374LDE)

---

### Community

#### Courses

(un-ordered, un-tested, some paid)

- https://pragmaticstudio.com/Elm
- https://www.pluralsight.com/courses/Elm
- https://frontendmasters.com/courses/intro-Elm/
- https://egghead.io/browse/languages/Elm
- https://courses.knowthen.com/p/Elm-for-beginners
- https://www.lynda.com/Elm-tutorials/771008-0.html

#### Discuss

[Discourse](https://discourse.Elm-lang.org/)

[Elm Slack](https://Elmlang.herokuapp.com/)

[Subreddit](https://www.reddit.com/r/Elm/)


---

