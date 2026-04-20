declare namespace math = "http://www.w3.org/2005/xpath-functions/math";

declare variable $caesar := doc("../xml/caesar_all_chapters.xml");
declare variable $coords := doc("../xml/MapCoords.xml");

declare variable $radiusScale := 6;
declare variable $defaultRadius := 4;

<html>
    <head>
        <title>Maps of Locations</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link type="text/css" href="style.css" rel="stylesheet"/>
    </head>

    <body>
        <nav>
            <div><a href="index.html">Home</a></div>
            <div><a href="background.html">Background</a></div>
            <div><a href="about.html">About</a></div>
            <div><a href="romanTable.html">Tables</a></div>
        </nav>

        <div class="main-content">
            <h1>Divide et Impera</h1>
            <h2>Places on Map</h2>

            <svg xmlns="http://www.w3.org/2000/svg"
                 width="1200"
                 height="1050"
                 viewBox="0 0 1613 1417">

                <style>
                    .river-dot {{
                        fill: steelblue;
                        fill-opacity: 0.65;
                        stroke: black;
                        stroke-width: 1.5;
                    }}

                    .settlement-dot {{
                        fill: darkred;
                        fill-opacity: 0.65;
                        stroke: black;
                        stroke-width: 1.5;
                    }}

                    .region-dot {{
                        fill: darkgreen;
                        fill-opacity: 0.65;
                        stroke: black;
                        stroke-width: 1.5;
                    }}

                    .mountain-dot {{
                        fill: goldenrod;
                        fill-opacity: 0.65;
                        stroke: black;
                        stroke-width: 1.5;
                    }}

                    .other-dot {{
                        fill: gray;
                        fill-opacity: 0.65;
                        stroke: black;
                        stroke-width: 1.5;
                    }}

                    .place-label {{
                        font-size: 18px;
                        fill: black;
                    }}

                    .place-count {{
                        font-size: 12px;
                        fill: white;
                        text-anchor: middle;
                        dominant-baseline: middle;
                    }}
                </style>

                <image href="Blank_map_of_Europe_cropped.svg"
                       x="0"
                       y="0"
                       width="1613"
                       height="1417"/>

                <g id="mapped-places">
                    {
                        for $coord in $coords//Q{}place
                        let $name := normalize-space(string($coord/@name))
                        let $x := xs:double($coord/@x)
                        let $y := xs:double($coord/@y)
                        let $type :=
                            if ($coord/@type)
                            then lower-case(string($coord/@type))
                            else "other"
                        let $count :=
                            count(
                                $caesar//Q{}place[
                                    normalize-space(translate(string(.), '[],', '')) = $name]
                            )
                        where $count > 0
                        let $r := math:sqrt($count) * $radiusScale + $defaultRadius
                        let $class :=
                            if ($type = "river") then "river-dot"
                            else if ($type = "settlement") then "settlement-dot"
                            else if ($type = "region") then "region-dot"
                            else if ($type = "mountain") then "mountain-dot"
                            else "other-dot"
                        order by $count descending, $name
                        return
                            <g>
                                <circle class="{$class}"
                                        cx="{$x}"
                                        cy="{$y}"
                                        r="{$r}"/>

                                <text class="place-count"
                                      x="{$x}"
                                      y="{$y}">
                                    {$count}
                                </text>

                                <text class="place-label"
                                      x="{$x + $r + 6}"
                                      y="{$y - 4}">
                                    {$name}
                                </text>
                            </g>
                    }
                </g>
            </svg>
        </div>
    </body>
</html>