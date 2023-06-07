module HItandblow exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Events exposing (..)
import Svg.Attributes exposing (..)
import Browser
import Types exposing (..)
import Panels exposing (..)

main = Browser.element { init=init
                         ,update=update
                         ,view=view
                         ,subscriptions=subscriptions
                         }



init: () -> (Model, Cmd Msg)
init _ = ({ target=[1,2,3,4]
           ,test = []
           ,history = []
           }
        ,Cmd.none)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Add num -> let
                    newTest = if (List.length model.test) < 4 then
                                model.test++[num]
                              else
                                model.test
                    dummy = Debug.log "" <| countHits model.target newTest
                   in
                    ({model | test=newTest}
                    , Cmd.none)
        Test -> ({model | test=[]
                        , history = model.history ++ [model.test]
                        }, Cmd.none)

countHits: List Int -> List Int -> Int
countHits target test =
    List.length <| 
    List.filter (\x -> x) <| 
    List.map2 (\x y -> x==y) target test


view: Model -> Html Msg
view model =
    Html.div []
        [svg [width "800"
             ,height "800"
             ]
             [inputPanel
             ,targetPanel model
             ,historyPanel model
             ]
        ]


subscriptions: Model -> Sub Msg
subscriptions model = Sub.none

 
