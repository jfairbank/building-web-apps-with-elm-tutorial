module JazzAlbums exposing (main)

import Html exposing (Html, div, h2, h3, i, img, input, label, li, text, ul)
import Html.Attributes exposing (class, classList, src, type_, value)
import Html.Events exposing (onClick, onInput)
import Regex


---- CONSTANTS ----


baseUrl : String
baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


type Rating
    = Unrated
    | Liked
    | Disliked


type alias Id =
    Int


type alias Album =
    { id : Id
    , title : String
    , coverUrl : String
    , artist : String
    , rating : Rating
    }


albums : List Album
albums =
    [ { id = 1
      , title = "Kind of Blue"
      , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
      , artist = "Miles Davis"
      , rating = Unrated
      }
    , { id = 2
      , title = "A Love Supreme"
      , coverUrl = baseUrl ++ "john-coltrane-a-love-supreme.jpg"
      , artist = "John Coltrane"
      , rating = Unrated
      }
    , { id = 3
      , title = "Out to Lunch"
      , coverUrl = baseUrl ++ "eric-dolphy-out-to-lunch.jpg"
      , artist = "Eric Dolphy"
      , rating = Unrated
      }
    , { id = 4
      , title = "Blue Train"
      , coverUrl = baseUrl ++ "john-coltrane-blue-train.jpg"
      , artist = "John Coltrane"
      , rating = Unrated
      }
    ]



---- MODEL ----


type alias Model =
    { albums : List Album
    , query : String
    }


initialModel : Model
initialModel =
    { albums = albums
    , query = ""
    }



---- UPDATE ----


updateRating : Rating -> Album -> Album
updateRating rating album =
    if album.rating == rating then
        { album | rating = Unrated }
    else
        { album | rating = rating }


like : Album -> Album
like =
    updateRating Liked


dislike : Album -> Album
dislike =
    updateRating Disliked


updateAlbum : (Album -> Album) -> Id -> List Album -> List Album
updateAlbum updater id albums =
    List.map
        (\album ->
            if album.id == id then
                updater album
            else
                album
        )
        albums



{--

STEP 1
======

Add a `Search` constructor to the `Msg` type. It will need to accept a `String`
argument that represents the query a user typed in.

--}


type Msg
    = Like Id
    | Dislike Id
    | Search String



{--

STEP 2
======

Add a branch for the `Search` message constructor. Unwrap the `query` in
`Search` and update the model's `query` field with it.

--}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Like id ->
            { model | albums = updateAlbum like id model.albums }

        Dislike id ->
            { model | albums = updateAlbum dislike id model.albums }

        Search query ->
            { model | query = query }



---- VIEW ----
{--

STEP 3
======

Fix the implementation to filter the albums according to the model query. You
should check the album title and artist to see if either matches the query. You
will need to use the `List.filter` function to filter the list according to the
query. You can read up on `List.filter` here:
http://package.elm-lang.org/packages/elm-lang/core/latest/List#filter.

Hint
----
Inside your filter function, you can use `String.contains` on the query and
album title and artist or build a `Regex` from the query and use
`Regex.contains`. `String.contains` will be simpler, but is case sensitive.
`Regex` can let you build a case-insensitive regex to search by. If you use
`Regex`, then you may also want to use `Regex.escape` to escape any special
characters in the query. The pipe |> operator will be useful for building up
your regex.

http://package.elm-lang.org/packages/elm-lang/core/latest/String#contains
http://package.elm-lang.org/packages/elm-lang/core/latest/Regex

Hint
----
A `let..in` expression may be useful here to introduce a local constant,
especially if you're using a regex.
http://elm-lang.org/docs/syntax#let-expressions

--}


filterAlbums : Model -> List Album
filterAlbums model =
    let
        containsQuery =
            model.query
                |> Regex.escape
                |> Regex.regex
                |> Regex.caseInsensitive
                |> Regex.contains
    in
    List.filter
        (\album ->
            containsQuery album.title || containsQuery album.artist
        )
        model.albums



{--

STEP 4
======

Use the `filterAlbums` function to pass in filtered albums to the
`viewAlbumList` function. Notice that the `filterAlbums` function accepts the
model as the argument, not the list itself.

--}


view : Model -> Html Msg
view model =
    div [ class "albums" ]
        [ viewAlbumFilters model
        , viewAlbumList (filterAlbums model)
        ]



{--

STEP 5
======

Replace the commented out `onInput` handler with an `onInput` handler that uses
the `Search` message constructor on the new query.

Hint
----
Although you can keep the anonymous function that accepts the typed query,
recall that the `Search` constructor is already a function that accepts a
query.

--}


viewAlbumFilters : Model -> Html Msg
viewAlbumFilters model =
    div [ class "album-filters" ]
        [ div [ class "album-filter" ]
            [ div []
                [ label [] [ text "Search Albums:" ] ]
            , input
                [ type_ "text"
                , value model.query
                , onInput Search
                ]
                []
            ]
        ]



{--

STEP 6
======

Display a "No matching albums" message if the list of albums is empty from the search.
Otherwise display the list of albums as normal.

Use the equivalent Elm syntax and Html functions to create this markup:
<div class="no-albums">No matching albums</div>

Hint
----
Check the `List` docs for a function that can help you here:
http://package.elm-lang.org/packages/elm-lang/core/latest/List

Hint
----
Alternatively, you can use pattern matching with a `case` expression on lists
too. Use these resources for a hint on the correct syntax:
* http://elm-lang.org/docs/syntax
* http://elmprogramming.com/pattern-matching.html

--}


viewAlbumList : List Album -> Html Msg
viewAlbumList albums =
    case albums of
        [] ->
            div [ class "no-albums" ]
                [ text "No matching albums" ]

        _ ->
            ul [ class "album-list" ]
                (List.map viewAlbum albums)


viewAlbum : Album -> Html Msg
viewAlbum album =
    li []
        [ div [ class "album" ]
            [ img [ src album.coverUrl ] []
            , div [ class "album__rating" ]
                [ i
                    [ class "far fa-lg fa-thumbs-up"
                    , classList [ ( "fa-thumbs-up--selected", album.rating == Liked ) ]
                    , onClick (Like album.id)
                    ]
                    []
                , i
                    [ class "far fa-lg fa-thumbs-down"
                    , classList [ ( "fa-thumbs-down--selected", album.rating == Disliked ) ]
                    , onClick (Dislike album.id)
                    ]
                    []
                ]
            , h2 [ class "album__title" ]
                [ text album.title ]
            , h3 [ class "album__artist" ]
                [ text album.artist ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
