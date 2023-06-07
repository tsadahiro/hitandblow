module Panels exposing (..)

import Types exposing (..)
import Svg exposing (..)
import Svg.Events exposing (..)
import Svg.Attributes exposing (..)

pal = [ "red"
        ,"green"
        ,"blue"
        ,"yellow"
        ,"orange"
        ,"purple"
        ]

inputPanel: Svg Msg
inputPanel =
    g [transform "translate(100,100)"]
    [inputButton 1 
    ,inputButton 2 
    ,inputButton 3 
    ,inputButton 4 
    ,inputButton 5 
    ,inputButton 6     
    ]

rad = 20

color: Int -> String
color num =
    (Maybe.withDefault ""<|
                    List.head <|
                    List.drop (num-1) pal)

inputButton: Int ->  Svg Msg
inputButton num =
    circle [cx <| String.fromInt (num*rad*2)
            ,cy <| String.fromInt rad
            ,fill <| color num
            ,r <| String.fromInt rad
            ,onClick (Add num)
            ]
            []

targetPanel: Model -> Svg Msg
targetPanel model =
    g [transform "translate(150,150)"]
    ((List.indexedMap
        (\i t -> 
        circle [cx <| String.fromInt (2*rad*i)
               ,cy <| String.fromInt rad
               ,r <| String.fromInt rad
               ,fill <| color t]
        [])
        model.test
    )++ [submitButton model]
    )

submitButton: Model -> Svg Msg
submitButton model =
    g [onClick Test]
        [rect [x <| String.fromInt (2*rad*(List.length model.target))
                ,y "5"
                ,width <| String.fromInt (2*rad)
                ,height <| String.fromInt rad
                ,fill "skyblue"
                ,stroke "black"
                ,rx "5"
                ][]
        ,text_ [fontSize "15"
                ,x <| String.fromInt (2*rad*(List.length model.target))
                ,y <| String.fromInt (rad)
                ,stroke "white"
                ,fill "white"
                ]
                [Svg.text "test"]            
        ]

historyLine : Int -> List Int -> List Int -> Svg Msg
historyLine idx test target =
    g [transform ("translate(150," ++
                    (String.fromInt (2*rad*idx+200))++
                    ")"
                 )
      ]
    ((List.indexedMap
        (\i t -> 
        circle [cx <| String.fromInt (2*rad*i)
               ,cy <| String.fromInt rad
               ,r <| String.fromInt rad
               ,fill <| color t]
        [])
        test
    )++ [text_ [fontSize "15"
                ,x <| String.fromInt (2*rad*(4))
                ,y <| String.fromInt (rad)
                ,stroke "black"
                ,fill "black"
                ]
                [text <| String.fromInt idx]            
        ]
    )

historyPanel: Model -> Svg Msg
historyPanel model =
    g []
     (List.indexedMap 
        (\idx test -> historyLine idx test model.target)
        model.history
    )
