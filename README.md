# Building Web Apps with Elm Tutorial

This repo contains demos and exercises for the "Building Web Apps with Elm"
tutorial.

## Setup

This workshop uses the wonderful [Ellie App](https://ellie-app.com) for running
Elm demos and exercises. Ellie is to Elm what JSBin or JSFiddle is to
JavaScript. However, we will use this repo and our local machines as backups if
we encounter any internet issues or if Ellie is down.

To be safe, **prior** to this tutorial follow these steps to ensure your local
machine is setup:

1. Install the latest **LTS** version of Node: currently **8.11.2**
    * **Recommended:** install via a version manager like **nvm**
      * For OS X and Linux install [**nvm**](https://github.com/creationix/nvm)
        * `nvm install --lts`
      * For Windows install [**nvm-windows**](https://github.com/coreybutler/nvm-windows)
        * 64-bit: `nvm install 8.11.2 64`
        * 32-bit: `nvm install 8.11.2 32`
    * Or download from [nodejs.org](https://nodejs.org)
2. Clone this repo
    * ```
      git clone https://github.com/jfairbank/building-web-apps-with-elm-tutorial.git
      cd building-web-apps-with-elm-tutorial
      ```
3. Install npm dependencies
    * ```
      npm install
      ```
4. Install Elm dependencies
    * ```
      npm run install:elm
      ```

Whether we use Ellie or our local machines, you will need a modern browser such
as Chrome or Firefox. If we use Ellie, make sure you're able to compile some of
the URLs below to verify your OS and browser can use Ellie. I've seen problems
with some Linux distros in the past.

For further local development setup, go
[here](#set-up-dependencies-for-elm-development).

## Structure

This tutorial is split between demos (we all follow along together) and
exercises (you and optionally a partner implement on your own). We will have
short reviews and time for Q&A after every exercise.

We will first look at some Elm syntax and functions. Then, we will focus the
rest of the tutorial on building a simple application that lets you rate and
search through a few jazz albums. As we work through the application, you can
follow along with the first starting file and add to it as we go along. We will
reach certain breaking points where you can pick up with a partially completed
file if you fall behind. The exercise files contain step-by-step instructions
for what you need to implement in the application, so feel free to switch to
those files or just open them up in a new tab to reference the instructions but
implement the code in the file you've already been working on.

## Run Locally

To run a demo or exercise locally, run this command with the appropriate file:

```
npm run run:elm <file>
```

A local development server should start on port 8000.
Open [http://localhost:8000](http://localhost:8000) in your browser to view the
demo/exercise.

For example, to run the "Syntax and Functions" demo you would run:

```
npm run run:elm demos/001-Functions.elm
```

Or to run the "Syntax and Functions" exercise you would run:

```
npm run run:elm exercises/002-Functions.elm
```

## Demo Starter Files

For demos, please use these starter files/URLs to follow along.

| Content | Filename | Ellie URL |
| ------- | -------- | --------- |
| Syntax and Functions | demos/001-Functions.elm | https://ellie-app.com/p6nNbVY6QYa1 |
| Static Applications | demos/003-JazzAlbums.elm | https://ellie-app.com/tKDmpNdRfga1 |
| Dynamic Applications | demos/004-JazzAlbums.elm | https://ellie-app.com/p6k2bXXcVwa1 |
| Working with Lists | demos/006-JazzAlbums.elm | https://ellie-app.com/p6kxLwXCrDa1 |
| Static Types and Type Aliases | demos/008-JazzAlbums.elm | https://ellie-app.com/p6m46vWvZHa1 |
| Input Events and Union Types | demos/009-JazzAlbums.elm | https://ellie-app.com/p6mG7crkzva1 |

## Completed Demos

Completed demos can be found at these files/URLs. The completed demos are helpful
if you fall behind and need a partially completed file to pick back up with.

| Content | Filename | Ellie URL |
| ------- | -------- | --------- |
| Syntax and Functions | completed-demos/001-Functions.elm | https://ellie-app.com/tKFbcTyhmka1 |
| Static Applications | completed-demos/003-JazzAlbums.elm | https://ellie-app.com/p6nbh7B6SFa1 |
| Dynamic Applications | completed-demos/004-JazzAlbums.elm | https://ellie-app.com/p6pNrZw39fa1 |
| Working with Lists | completed-demos/006-JazzAlbums.elm | https://ellie-app.com/p6q9xfkntra1 |
| Static Types and Type Aliases | completed-demos/008-JazzAlbums.elm | https://ellie-app.com/p6qyzyymWZa1 |
| Input Events and Union Types | completed-demos/009-JazzAlbums.elm | https://ellie-app.com/rMkVmjhyJLa1 |

## Exercises

Use these files/URLs for the hands-on exercises. Instructions are provided
inside each file.

| Content | Filename | Ellie URL |
| ------- | -------- | --------- |
| Syntax and Functions | exercises/002-Functions.elm | https://ellie-app.com/p6s6NTLLw3a1 |
| Enhance a Dynamic Application | exercises/005-JazzAlbums.elm | https://ellie-app.com/p6sWQ6PRMRa1 |
| Working with Lists | exercises/007-JazzAlbums.elm | https://ellie-app.com/p6tkdg7Nv2a1 |
| Input Events and Union Types | exercises/010-JazzAlbums.elm | https://ellie-app.com/rMBPb96nVva1 |

## Completed Exercises

Use these files/URLs to see the completed exercises. Please refrain from viewing
these files until you've attempted the exercises yourself. Click "Details" below
to expand.

<details>

| Content | Filename | Ellie URL |
| ------- | -------- | --------- |
| Syntax and Functions | completed-exercises/002-Functions.elm | https://ellie-app.com/p6vyYwsXj8a1 |
| Enhance a Dynamic Application | completed-exercises/005-JazzAlbums.elm | https://ellie-app.com/p6vW7v94YQa1 |
| Working with Lists | completed-exercises/007-JazzAlbums.elm | https://ellie-app.com/p6wkYZDXpWa1 |
| Input Events and Union Types | completed-exercises/010-JazzAlbums.elm | https://ellie-app.com/rMCkRSMBkBa1 |

</details>

## Set Up Dependencies for Elm Development

These are typical global dependencies you will want installed for developing in
Elm in general.

Please note that I am a Vim user, so I've only minimally tested the plugins for
other editors below. If you don't see your favorite editor listed, please find
the best Elm plugins for it and submit a PR!

1. Install global dependencies
    1. Install **Elm** via **npm**
        * `npm install -g elm`
    2. Install supporting Elm packages via **npm**
        * [**elm-format**](https://github.com/avh4/elm-format)
          * Format Elm code to a unified community standard.
          * `npm install -g elm-format`
        * [**elm-oracle**](https://github.com/ElmCast/elm-oracle)
          * Autocompletion for Elm code.
          * `npm install -g elm-oracle`
2. Install helpful plugins for your IDE or text editor
    * **Vim** (with a package manager like [vim-plug](https://github.com/junegunn/vim-plug) or [Vundle](https://github.com/VundleVim/Vundle.vim))
      * [**Valloric/YouCompleteMe**](https://github.com/Valloric/YouCompleteMe)
        * General Vim autocompletion.
      * [**w0rp/ale**](https://github.com/w0rp/ale)
        * **Recommended:** General Vim linting and typechecking.
        * **NOTE:** Requires NeoVim or Vim 8. 
      * [**vim-syntastic/syntastic**](https://github.com/vim-syntastic/syntastic)
        * General Vim linting and typechecking.
        * **NOTE:** Use if you're not using NeoVim or Vim 7. 
      * [**ElmCast/elm-vim**](https://github.com/ElmCast/elm-vim)
        * Syntax highlighting, indentation, autocompletion, autoformatting.
        * Requires previous Vim plugins.
    * [**VS Code**](https://code.visualstudio.com/)
      * [**vscode-elm**](https://github.com/sbrink/vscode-elm)
        * `ext install elm`
    * [**Atom**](https://atom.io/)
      * [**language-elm**](https://github.com/edubkendo/atom-elm)
      * [**linter-elm-make**](https://github.com/mybuddymichael/linter-elm-make)
      * [**elm-format**](https://github.com/triforkse/atom-elm-format)
      * [**elmjutsu**](https://github.com/halohalospecial/atom-elmjutsu)
    * [**Sublime**](https://www.sublimetext.com/)
      * Via [**Package Control**](https://packagecontrol.io/)
        * **Elm Language Support**
        * **Highlight Build Errors**
    * Missing your IDE or editor? Make a PR please!
