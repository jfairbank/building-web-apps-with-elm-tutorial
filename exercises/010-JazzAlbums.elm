module JazzAlbums exposing (main)

import Html exposing (Html, div, h2, h3, i, img, input, label, li, text, ul)
import Html.Attributes exposing (class, classList, src, type_, value)
import Html.Events exposing (onClick, onInput)


---- CONSTANTS ----


baseUrl : String
baseUrl =
    "https://jazz-album-covers.surge.sh/images/"



{--

STEP 1
======

a. Change Rating to a union type with three constructors: Unrated, Liked,
   Disliked. These constructors don't need arguments like the Msg constructors.

b. Delete the old unrated, liked, and disliked constants below and update
   the code to use the new union type constructors.

       unrated  -> Unrated
       liked    -> Liked
       disliked -> Disliked

--}


type alias Rating =
    Int


unrated : Rating
unrated =
    0


liked : Rating
liked =
    1


disliked : Rating
disliked =
    2


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
      , rating = unrated
      }
    , { id = 2
      , title = "A Love Supreme"
      , coverUrl = baseUrl ++ "john-coltrane-a-love-supreme.jpg"
      , artist = "John Coltrane"
      , rating = unrated
      }
    , { id = 3
      , title = "Out to Lunch"
      , coverUrl = baseUrl ++ "eric-dolphy-out-to-lunch.jpg"
      , artist = "Eric Dolphy"
      , rating = unrated
      }
    , { id = 4
      , title = "Blue Train"
      , coverUrl = baseUrl ++ "john-coltrane-blue-train.jpg"
      , artist = "John Coltrane"
      , rating = unrated
      }
    ]



---- MODEL ----


type alias Model =
    { albums : List Album
    , query : String
    }


initialModel : Model
initialModel =
    Model albums ""



---- UPDATE ----


updateRating : Rating -> Album -> Album
updateRating rating album =
    if album.rating == rating then
        { album | rating = unrated }
    else
        { album | rating = rating }


like : Album -> Album
like =
    updateRating liked


dislike : Album -> Album
dislike =
    updateRating disliked


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


type Msg
    = Like Id
    | Dislike Id
    | Search String



{--

STEP 2
======

Replace the wildcard _ handler with a `Search` message handler to update the
query stored in the model.

--}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Like id ->
            { model | albums = updateAlbum like id model.albums }

        Dislike id ->
            { model | albums = updateAlbum dislike id model.albums }

        _ ->
            model



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
    model.albums



{--

STEP 4
======

a. Display the album search above the album list by calling the
   `viewAlbumFilters` function inside the `view` function.

b. Use the `filterAlbums` function to pass in filtered albums to the
   `viewAlbumList` function. Notice that the `filterAlbums` function accepts
   the model as the argument, not the list itself.

--}


view : Model -> Html Msg
view model =
    div [ class "albums" ]
        [ viewAlbumList model.albums ]



{--

STEP 5
======

Replace the commented out `onInput` handler with an `onInput` handler that uses
the `Search` message constructor on the new query.

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

                -- , onInput (\query -> { type_ = "SEARCH", id = -1, query = query })
                ]
                []
            ]
        ]


viewAlbumList : List Album -> Html Msg
viewAlbumList albums =
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
                    , classList [ ( "fa-thumbs-up--selected", album.rating == liked ) ]
                    , onClick (Like album.id)
                    ]
                    []
                , i
                    [ class "far fa-lg fa-thumbs-down"
                    , classList [ ( "fa-thumbs-down--selected", album.rating == disliked ) ]
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
