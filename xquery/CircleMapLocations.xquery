declare variable $caesar := doc("../xml/caesar_all_chapters.xml");

declare variable $bookSpacing := 180;
declare variable $leftMargin := 120;
declare variable $topMargin := 80;
declare variable $circleGap := 85;
declare variable $radiusScale := 3;

<html>
    <head>
        <title>Page 5</title>
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
            <h2>Places by Book</h2>
            
            {
                let $books := $caesar//Q{}book
                let $bookCount := count($books)
                let $svgHeight := ($bookCount * $bookSpacing) + 100
                
                return
                    <svg xmlns="http://www.w3.org/2000/svg" width="1400" height="{$svgHeight}">
                        {
                            for $book at $bpos in $books
                            let $booknum := xs:integer($book/@num)
                            let $y := $topMargin + (($bpos - 1) * $bookSpacing)
                            
                            let $places :=
                                for $placename in distinct-values($book//Q{}place/text())
                                let $count := count($book//Q{}place[text() = $placename])
                                where normalize-space($placename) != ""
                                order by $count descending, $placename
                                return
                                    <place>
                                        <name>{$placename}</name>
                                        <count>{$count}</count>
                                    </place>
                            
                            return
                                <g>
                                    <!-- Book label -->
                                    <text x="20" y="{$y}" font-size="22" font-weight="bold">
                                        Book {$booknum}
                                    </text>
                                    
                                    <!-- baseline -->
                                    <line x1="{$leftMargin}" 
                                          y1="{$y}" 
                                          x2="1300" 
                                          y2="{$y}" 
                                          stroke="black" 
                                          stroke-width="1"/>
                                    
                                    <!-- circles -->
                                    {
                                        for $place at $pos in $places
                                        let $name := $place/name/string()
                                        let $count := xs:integer($place/count/string())
                                        let $cx := $leftMargin + (($pos - 1) * $circleGap)
                                        let $r := $count * $radiusScale
                                        return
                                            <g>
                                                <circle cx="{$cx}"
                                                        cy="{$y}"
                                                        r="{$r}"
                                                        fill="darkred"
                                                        fill-opacity="0.65"
                                                        stroke="black"/>
                                                
                                                <text x="{$cx}"
                                                      y="{$y + $r + 18}"
                                                      font-size="12"
                                                      text-anchor="middle">
                                                    {$name}
                                                </text>
                                                
                                                <text x="{$cx}"
                                                      y="{$y + 4}"
                                                      font-size="12"
                                                      text-anchor="middle"
                                                      fill="white">
                                                    {$count}
                                                </text>
                                            </g>
                                    }
                                </g>
                        }
                    </svg>
            }
        </div>
    </body>
</html>