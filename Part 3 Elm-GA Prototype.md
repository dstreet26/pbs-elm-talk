class: middle, center

# Elm at PBS

---

## .faded[Part 1 Elm introduction and syntax]

## .faded[Part 2 Lessons learned from Otter and Tizen]

## Part 3 Elm-GA prototype thoughts

---

---

Part 3 Elm-GA prototype thoughts
talk about the rebrand and the app

---

    show commit graph

---

    what problems does it solve?
        live-reloading
        fine grained control over what we know
        ports for things we don't know until runtime
        better architecture that reduces many large json requests
        only one place where keyboard logic happens, easy to drill into
                coding in practice
                adding a new feature means changing the Model, maybe adding a message, and following the compiler to help implement what needs to be implemented
                debugging application logic is straightforward because there is only one place that data is "updated"



        small static css file
        nothing can ever be "out of focus", likewise errors like "cannot call setFocus() of undefined" cannot happen

---

        no more promise-hell; requests all have the same type and are handled in the same place as every Msg, in the update function

---

        business logic like how to format

```elm
viewParentAbove : Parent -> String
viewParentAbove parent =
    case parent of
        Season _ ->
            "Season"

        Special x ->
            case x.show.franchise of
                Nothing ->
                    "Special " ++ "|" ++ x.show.title

                Just franchise ->
                    "Special From " ++ franchise.title

        Show x ->
            case x.franchise of
                Nothing ->
                    "Show " ++ x.title

                Just y ->
                    "From " ++ y.title

        Episode x ->
            case x.season.show.franchise of
                Nothing ->
                    "Episode " ++ x.season.title

                Just franchise ->
                    "Episode | From " ++ franchise.title
```

---

    if the project is approved:
        we will come up with a name
        add the repo
        start adding tickets from a text list
        set up ci/cd + tv builds + eden

---

smarttv
live-reloading is a must (hot-reloading is okay but generally only works for css changes)
2015: we cannot inpsect anything
2016: we can inpsect the html, css, and console. debugging is limited to code files that are shorter than ~5kloc, the debugger will freeze for large code files (like anything that is vendorized) so you have to be careful when stepping through lines
2017: doesn't freeze for large files, can execute js from the console
in otter, you have to rebrand and restart to see your changes:
ctrl+c
npm run start:ga
wait
reload the app on the tv
  
 fixed dimensions (no responsiveness needed) (flexbox is not reliable anyways on older tv's)
no address bar, so using the canonical React Router isn't necessary (the app also breaks anyways if you don't load it from root)

    limited input (up, down, left, right, enter, back)
    separation of tv-specific api's and normal app code
    flags for different environments
        type Platform = Browser | Samsung2015 | Samsung2016 | Samsung2017 | Vizio | LG
        type Environment = Dev | Prod
    otter-specific
        styled components are hard to inspect (everything turns into `<div class="css-hzf72n"></div>`)
        going to a different "Screen" in the app re-loads content data
        module splitting is the main reason why pushing a release out breaks the app for users until they restart
            example (there's actually 25 files for GA that do this, i'm just showing one)
                HomeScreen.5a7abfd9.chunk.js -> HomeScreen.07ecc93f.chunk.js

        we've found out that we need much more fine-grained control over stuff that would normally be a React Component
            performance problems are hard to fix when you're using 125kb(gzipped) of outside js
            video-react needed to be pulled in and modified because of a Samsung2016 issue
            hls.js needed to be pulled in and modified because of a Samsung2015 issue

perf:
tree-shaking/dead-code-elimination
compiler speed
app performance
most of the speedup from the Elm prototype comes from the fact that there are very few ways that data changes (compared to otter), it's just Msg and Update

it's time to give an Elm tech talk
  
 google slides, powerpoint, or a web page
probably a different talk for different things
intro to Elm
what is it and where does it fit?
(just something that you can give an Elm file and it will produce a js output)
syntax
Elm in y minutes
difference between IF statement and IF expression
case \_ of is the recommended way of handling application logic
to pipe or not?
mylist |> map someFunction |> filter somePredictate |> take 5
take 5 (filter somePredicate (map someFunction mylist))
take 5 <| filter somePredicate <| map someFunction mylist
Benefits
coding in practice
adding a new feature means changing the Model, maybe adding a message, and following the compiler to help implement what needs to be implemented
debugging application logic is straightforward because there is only one place that data is "updated"
  
 Drawbacks
elephant in the room, i'm (probably) the only one at PBS that has used Elm

---

ANDs and ORs
https://discourse.Elm-lang.org/t/mapping-tagged-union-types-to-other-languages/2417
A record type is a ‘product’; an instance of a record is a member of the set defined by the cross product of the sets defined by each of its fields.

    A union type is a ‘sum’; an instance of a union type is a member of the set defined by taking the union of the sets defined by each of its constructors. That gives you a new angle on data modelling that is not so well expressed in some other languages and better enables choices to be encoded.

    ^^that also has an example of various ways to achieve similar results, all with drawbacks

    it mentions that ts and flow have Discriminated Unions:
    http://www.typescriptlang.org/docs/handbook/advanced-types.html#discriminated-unions

    that's where you do Type SomeType = SomeRecordA | SomeOtherRecordB | SomeOtherRecordC

    this doesn't allow sharing like: Type SomeType = SomeRecordA SomeDataStructure1 | SomeOtherRecordB SomeDataStructure2 | SomeOtherRecordC SomeDataStructure2

    ^^ does that even happen in real code?

Records and Enums

Elm: Type Aliases and Types

---

Tagged Unions, what are they in Elm and what are they in other languages?

---

Business + Ergonomic +

Business
No runtime errors (which are expensive, Sentry + PBS Support)
Performance
Build size
Predictable development speed (TV capabilities aside)

Ergonomic - good for the developer
Helpful error messages
Canonical formatter
Canonical package manager (versions are managed for you, no js allowed)
Packages from people way smarter at a particular thing
VSC integration is more than enough for everyday

---

Elm makes it easy to do the right thing and hard or impossible to do the wrong thing. TypeScript makes it possible to do the right thing, and gives you a couple switches you can flip to make it harder to do the wrong things, but will ultimately let you do anything.



[https://www.gizra.com/content/thinking-choosing-elm/](Amitai Burstein)

Pro & Cons
Lets start with the main Elm cons:

It’s not mainstream.
Community is small, which means there aren’t tons of libraries out there, so you’ll have to scratch your own itch more often then not.
There aren’t many blog posts/tutorials out there, surely compared to popular frameworks such as React.
High learning curve with a new unknown syntax which is not JS.
It’s different from other things we know.
And the pros, which are totally subjective:

It’s not JS. Obviously this statement is controversial, but it’s no secret that JS can be very confusing.
Having this high learning curve has an interesting side effect: all the developers in the issue queue/mailing list, even the newbies, are seasoned developers. It’s amazing to see how rapidly newcomers learn the new stuff, and contribute back.
Once you pick up the concepts, and follow the Elm architecture, the pieces start falling really neatly into their natural place. Each component in your app has the exact same structure as the other components and the root component itself.
There’s a compiler that stops you from screwing things up - as we humans constantly tend to do.
It’s different from other things we know. I think it’s actually good, because we kind of had enough of “the old way” (read as “Angular 1”). Even Aurelia with its great DX and even React & Redux with their immense popularity and community felt as a step in the right direction, but not the radical new approach to the problem we were looking for.


