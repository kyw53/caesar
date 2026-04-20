declare namespace math = "http://www.w3.org/2005/xpath-functions/math";

declare variable $caesar := doc("../xml/caesar_all_chapters.xml");
declare variable $coords := doc("../xml/MapCoords.xml");

declare variable $maxRadius := 50;
declare variable $minRadius := 5;

let $globalMax :=
    max(
        for $book in $caesar//Q{}book
        for $coord in $coords//Q{}place
        let $name := normalize-space(string($coord/@name))
        let $count := count($book//Q{}place[normalize-space(translate(string(.), '[],', '')) = $name])
        return $count
    )

return
<html>
    <head>
        <title>Maps of Locations by Book</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link type="text/css" href="style.css" rel="stylesheet"/>

        <script>
            function showBook(bookNum) {{
                let maps = document.querySelectorAll(".book-map");
                maps.forEach(function(map) {{map.style.display = "none";}});

                let target = document.getElementById("book-" + bookNum);
                if (target) {{target.style.display = "block";}}}}
        </script>

        <style>
            .book-buttons {{
                margin-bottom: 20px;
            }}

            .book-buttons button {{
                margin-right: 8px;
                margin-bottom: 8px;
                padding: 8px 12px;
                font-size: 16px;
                cursor: pointer;
                background: #6B1F1F;
                color: #e3ddc8;
                font-family: 'Cinzel', serif;
                font-weight: bold;
            }}

            .book-map {{
                display: none;
            }}

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
    </head>

    <body onload="showBook(1)">
        <nav>
            <div><a href="index.html">Home</a></div>
            <div><a href="background.html">Background</a></div>
            <div><a href="about.html">About</a></div>
            <div><a href="romanTable.html">Tables</a></div>
        </nav>

        <div class="main-content">
            <h1>Divide et Impera</h1>
            <h2>Frequency of Locations Mentioned by Book</h2>

            <div class="book-buttons">
                {
                    for $book in $caesar//Q{}book
                    let $num := string($book/@num)
                    return
                        <button onclick="showBook({$num})" >Book {$num}</button>
                }
            </div>

            {
                for $book in $caesar//Q{}book
                let $num := string($book/@num)
                return
                    <div class="book-map" id="book-{$num}">
                        <h3>Book {$num}</h3>

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="1200"
                             height="1050"
                             viewBox="0 0 1613 1417">

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
                                    let $count :=count($book//Q{}place[normalize-space(translate(string(.), '[],', '')) = $name])
                                    where $count > 0
                                    let $r :=
                                        if ($globalMax > 0)
                                        then (math:sqrt($count div $globalMax) * $maxRadius) + $minRadius
                                        else $minRadius
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
                            <g id="legend" transform="translate(40,1250)">
                                
                                <rect x="0" y="0" width="200" height="150"
                                      fill="white" fill-opacity="0.8"
                                      stroke="black" stroke-width="1"/>
                            
                                <text x="10" y="15" font-size="16" font-weight="bold">
                                    Map Key
                                </text>
                            
                                <circle cx="15" cy="35" r="8" class="river-dot"/>
                                <text x="30" y="40" font-size="14">River</text>
                            
                                <circle cx="15" cy="60" r="8" class="settlement-dot"/>
                                <text x="30" y="65" font-size="14">Settlement</text>
                            
                                <circle cx="15" cy="85" r="8" class="region-dot"/>
                                <text x="30" y="90" font-size="14">Region</text>
                            
                                <circle cx="15" cy="110" r="8" class="mountain-dot"/>
                                <text x="30" y="115" font-size="14">Mountain</text>
                            
                                <circle cx="15" cy="135" r="8" class="other-dot"/>
                                <text x="30" y="140" font-size="14">Other</text>
                            
                            </g>
                        </svg>
                    </div>
            }
        </div>
        <div class="main-content">
            <p>This map visualizes how frequently locations are mentioned in the text on a book-by-book basis. Each place referenced in the text is plotted at its approximate real-world location and represented by a circle. The size of each circle reflects how often that place is mentioned within a given book, with larger circles indicating greater frequency. Circle sizes are scaled relative to the maximum number of mentions across all books, allowing for direct comparison between them. Colors distinguish between different types of places, including regions, settlements, rivers, and mountains.</p>
        </div>
    </body>
</html>