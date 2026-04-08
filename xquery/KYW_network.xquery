declare namespace math = "http://www.w3.org/2005/xpath-functions/math";
declare variable $section := //section/data(@part);
declare variable $x-spacer := 55;
declare variable $y-spacer := 45;
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;
<html>
    <head>
        <title>Network</title>
        <link type="text/css" href="style.css" rel="stylesheet" />
    </head>
    <body>
        <nav>
            <div><a href="index.html">Home</a></div>
            <div><a href="background.html">Background</a></div>
            <div><a href="about.html">About</a></div>
            <div><a href="romanTable.html">Tables</a></div>
            <div><a href="page5.html">Page 5</a></div>
        </nav>
        
    <div class="main-content">
    <h1>Divide et Impera</h1>
    <h2>Kyle's Network Diagram</h2>
    <h3>Mostly functional at last</h3>
    <p>
        <div class="kyle-svg">
        <svg xmlns="http://www.w3.org/2000/svg" width="auto" height="auto" viewBox="-125 -800 1250 600">
            <desc>A network graph</desc>
            {
            let $num := $text/Q{}book/(@num)
            for $book at $num in $g_books
            return <g>
            <line x1="200" x2="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200}" y1="-500" y2="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) ))}" stroke="#8a2b2b" opacity="25%"/>
            
            
            </g>
            }
                {
                    let $g_books := $text//Q{}section[@part="gaul"]//Q{}book
                    for $book in $g_books
                    let $num := $book/@num
                    group by $num 
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    return <g>
                    
                    
                    <line x1="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200}" x2="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200 +($x-spacer*math:cos(36*($pos)))}" y1="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) )) }" y2="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) )) - ($y-spacer*math:sin(36*($pos)))}" stroke="#8a2b2b" opacity="25%" stroke-width="{math:sqrt($roman-count)}"/>
                    
                    <circle r="12.5" cx="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200}" cy="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) ))}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 * math:cos(40 * ($num))) + 200}" y="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) ))}" text-anchor="middle" font-size="6">Book {($num)}</text>
                    <circle r="10.5" cx="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200 +($x-spacer*math:cos(36*($pos)))}" cy="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) )) - ($y-spacer*math:sin(36*($pos)))}" fill="green" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 200 +($x-spacer*math:cos(36*($pos)))}" y="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) )) - ($y-spacer*math:sin(36*($pos)))}" text-anchor="middle" font-size="6">{$roman}</text>
                    </g>
                }
                
            {
            let $num := $text/Q{}book/(@num)
            for $book at $num in $c_books
            return <g>
            <line x1="800" x2="{($x-spacer * 4.5 *math:cos(40 * ($num))) + 800}" y1="-500" y2="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num) ))}" stroke="#8a2b2b" opacity="25%"/>
            (: KYW: line from section title to book nodes :)
            
            </g>
            }
                {
                    
                    for $book in $c_books
                    let $num := $book/@num
                    group by $num 
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    let $third-spacer := 5
                    (:KYW: spot for conditional?:)
                    return <g>
                    <line x1="{($x-spacer * 4.5 *math:cos(40 * ($num - 8))) + 800}" x2="{($x-spacer * 4.5 *math:cos(40 * ($num - 8))) + 800 +($x-spacer*math:cos(40*($pos)))}" y1="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num - 8) )) }" y2="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num - 8) )) - ($y-spacer*math:sin(40*($pos)))}" stroke="#8a2b2b" opacity="25%" stroke-width="{math:sqrt($roman-count)}"/>
                    (: KYW: line from book node to Roman nodes :)
                    
                    <circle r="12.5" cx="{($x-spacer * 4.5 *math:cos(40 * ($num -8))) + 800}" cy="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num -8) ))}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 * math:cos(40 * ($num -8))) + 800}" y="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num -8) ))}" text-anchor="middle" font-size="6">Book {($num -8)}</text>
                    
                    <circle r="10.5" cx="{($x-spacer * 4.5 *math:cos(40 * ($num - 8))) + 800 +($x-spacer*math:cos(40*($pos)))}" cy="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num - 8) )) - ($y-spacer*math:sin(40*($pos)))}" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 *math:cos(40 * ($num - 8))) + 800 +($x-spacer*math:cos(40*($pos)))}" y="{-500 - ($y-spacer * 4.5 *math:sin(40 * ($num - 8) )) - ($y-spacer*math:sin(40*($pos)))}" text-anchor="middle" font-size="6">{$roman}</text>
                    </g>
                }    
            <g alignment-baseline="baseline" transform="translate(0, 0)">
            <line x1="200" x2="512.5" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
            <line x1="500" x2="787.5" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
            
            <circle r="20.5" cx="500" cy="-500" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
            <text x="500" y="-500" text-anchor="middle" font-size="8">Caesar</text>
            
            <circle r="20.5" cx="200" cy="-500" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
            <text x="200" y="-500" text-anchor="middle" font-size="6.5">Gallic Wars</text>    
            
            <circle r="20.5" cx="800" cy="-500" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
            <text x="800" y="-500" text-anchor="middle" font-size="8">Civil War</text>
            
            </g>
        </svg>
        </div>
        </p>
        </div>
        </body>
        </html>