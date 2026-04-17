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
    
        <!-- coordinate script
        <script type="text/javascript"><![CDATA[
            var myX, myY, xyOn = true, myMouseX, myMouseY;
    
            document.onmouseup = getXYPosition;
    
            function getXYPosition(e) {
                const svg = document.querySelector("svg");
            
                const pt = svg.createSVGPoint();
                pt.x = e.clientX;
                pt.y = e.clientY;
            
                const svgPoint = pt.matrixTransform(svg.getScreenCTM().inverse());
            
                alert("SVG X: " + svgPoint.x + "\nSVG Y: " + svgPoint.y);
            }
    
            function toggleXY() {
                xyOn = !xyOn;
                return false;
            }
        ]]></script>-->
        
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
            
            {
                let $places :=
                    for $placename in distinct-values($caesar//Q{}place/text())
                    let $cleanName := normalize-space(translate($placename, '[],', ''))
                    let $count := count($caesar//Q{}place[normalize-space(translate(., '[],', '')) = $cleanName])
                    where $cleanName != ""
                    order by $count descending, $cleanName
                    return
                        <place>
                            <name>{$cleanName}</name>
                            <count>{$count}</count>
                        </place>

                return
                    <svg xmlns="http://www.w3.org/2000/svg"
                         width="1200"
                         height="1050"
                         viewBox="0 0 1613 1417">
                        
                        <style>
                            .place-dot {{
                                fill: darkred;
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

                        <!-- background map -->
                        <image href="Blank_map_of_Europe_cropped.svg"
                               x="0"
                               y="0"
                               width="1613"
                               height="1417"/>

                        <!-- plotted places -->
                        <g id="mapped-places">
                            {
                                for $place in $places
                                let $name := $place/Q{}name/string()
                                let $count := xs:integer($place/Q{}count/string())
                                let $coord := $coords//Q{}place[@name = $name]
                                where $coord
                                let $x := xs:double($coord/@x)
                                let $y := xs:double($coord/@y)
                                let $r := math:sqrt($count) * $radiusScale + $defaultRadius
                                return
                                    <g>
                                        <circle class="place-dot"
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
            }
        </div>
    </body>
</html>