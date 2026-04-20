declare namespace math = "http://www.w3.org/2005/xpath-functions/math";
declare variable $section := //section/data(@part);
declare variable $x-spacer := 60;
declare variable $y-spacer := 45;
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;
<html>
    <head>
        <title>Network Diagram</title>
        <link type="text/css" href="style.css" rel="stylesheet" />
    </head>
    <body>
        <nav>
            <div><a href="index.html">Home</a></div>
            <div><a href="background.html">Background</a></div>
            <div><a href="about.html">About</a></div>
            <div><a href="romanTable.html">Tables</a></div>
            <div class="dropdown"><a href="#">Graphs and Data</a>
                <div class="dropdown-content">
                    <a href="network-output.html">Network Diagram</a>
                    <a href="ethnicity-count.html">Ethicity Count</a>
                    <a href="BarGraphLocations.html">Location Count</a>
                    <a href="unitGraph.html">Map Graph</a>
                    <a href="CaesarMentionsBarGraph.html">Caesar Mentions</a>
                </div>
            </div>
        </nav>
        
    <div class="main-content">
    <h1>Divide et Impera</h1>
    <h2>Kyle's Network Diagram</h2>
    <h3>Mostly functional at last</h3>
    <p>
        <div class="kyle-svg">
        <svg xmlns="http://www.w3.org/2000/svg" width="auto" height="auto" viewBox="-275 -850 1550 700">
            <desc>A network graph</desc>
            {
            let $num := $text/Q{}book/(@num)
            for $book at $num in $g_books
            let $fn_x_1 := math:cos(40 * ($num))
            let $fn_y_1 := math:sin(40 * ($num) )
            return <g>
            <line x1="100" x2="{($x-spacer * 4.5 *$fn_x_1) + 100}" y1="-500" y2="{-500 - ($y-spacer * 4.5 *$fn_y_1)}" stroke="#7851A9" opacity="75%"/>
            (: KYW: edge from section node to book nodes :)
            
            
                />
            </g>
            }
                {
                    
                    for $book in $g_books
                    let $num := $book/@num
                    group by $num 
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    let $third-spacer := 5
                    let $fn_x_1 := math:cos(40 * ($num))
                    let $fn_x_2 := math:cos(36*($pos))
                    let $fn_y_1 := ($y-spacer * 4.5 *math:sin(40 * ($num) ))
                    let $fn_y_2 := math:sin(36*$pos)
                    return <g>
                    
                    
                     <path d="M{($x-spacer * 4.5 * $fn_x_1) + 100},{-500 - $fn_y_1} 
                                                    A10,10 0 0,1 {($x-spacer * 4.5 * $fn_x_1) + 100 + ($x-spacer + $third-spacer)*$fn_x_2},{-500 - $fn_y_1 - ($y-spacer + $third-spacer)*$fn_y_2}"
                    stroke="#8a2b2b" fill="none" opacity="25%" stroke-width="{math:sqrt($roman-count)}"
                />
                    (: KYW: edge from book node to Roman nodes; M gives the starting point for A, whose parameters are: A(x-radius, y-radius) (x-rotation) (large flag, sweep flag) (final-x, final-y) :)
                    
                    <circle r="12.5" cx="{($x-spacer * 4.5 *$fn_x_1) + 100}" cy="{-500 - $fn_y_1}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 * $fn_x_1) + 100}" y="{-500 - $fn_y_1}" text-anchor="middle" font-size="6">Book {($num)}</text>
                    (: KYW: nodes and text for books
                    
                    <circle r="10.5" cx="{($x-spacer * 4.5 *$fn_x_1) + 100 +(($x-spacer+$third-spacer)*$fn_x_2)}" cy="{-500 - $fn_y_1 - (($y-spacer+$third-spacer)*$fn_y_2)}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 *$fn_x_1) + 100 +(($x-spacer+$third-spacer)*$fn_x_2)}" y="{-500 - $fn_y_1 - (($y-spacer+$third-spacer)*$fn_y_2)}" text-anchor="middle" font-size="6">{$roman}</text>
                    (: KYW: nodes and text for Romans :)
                    
                    </g>
                }
                
            {
            let $num := $text/Q{}book/(@num)
            for $book at $num in $c_books
            let $fn_x_1 := math:cos(40 * ($num))
            let $fn_y_1 := math:sin(40 * ($num) )
            return <g>
            <line x1="900" x2="{($x-spacer * 4.5 *$fn_x_1) + 900}" y1="-500" y2="{-500 - ($y-spacer * 4.5 *$fn_y_1)}" stroke="#7851A9" opacity="75%"/>
            (: KYW: edge from section node to book nodes :)
            
            </g>
            }
                {
                    
                    for $book in $c_books
                    let $num := $book/@num
                    group by $num 
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    let $total-count :=$text//Q{}persName[data(@nameid) = $roman] =>count()
                    let $third-spacer := 85
                    let $fn_x_1 := math:cos(40 * ($num - 8))
                    let $fn_x_2 := math:cos(40*($pos))
                    let $fn_y_1 := math:sin(40 * ($num - 8) )
                    let $fn_y_2 := math:sin(40*($pos))
                    (:KYW: spot for conditional?:)
                    
                    return <g>
                    
                    
                    <path d="M{($x-spacer * 4.5 * $fn_x_1) + 900},{-500 - ($y-spacer * 4.5 *$fn_y_1)} 
                                                    A10,10 0 0,1 {($x-spacer * 4.5 * $fn_x_1) + 900 + ($x-spacer + $third-spacer)*$fn_x_2},{-500 - ($y-spacer * 4.5 * $fn_y_1) - ($y-spacer + $third-spacer)*$fn_y_2}"
                    stroke="#8a2b2b" fill="none" opacity="25%" stroke-width="{math:sqrt($roman-count)}"
                />
                    (: KYW: edge from section node to Roman nodes
                    
                    <circle r="12.5" cx="{($x-spacer * 4.5 *$fn_x_1) + 900}" cy="{-500 - ($y-spacer * 4.5 *$fn_y_1)}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 * $fn_x_1) + 900}" y="{-500 - ($y-spacer * 4.5 *$fn_y_1)}" text-anchor="middle" font-size="6">Book {($num -8)}</text>
                    (: KYW: book nodes :)
                    
                    <circle r="10.5" cx="{($x-spacer * 4.5 *$fn_x_1) + 900 +(($x-spacer+$third-spacer)*$fn_x_2)}" cy="{-500 - ($y-spacer * 4.5 *$fn_y_1) - (($y-spacer+$third-spacer)*$fn_y_2)}" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
                    <text x="{($x-spacer * 4.5 *$fn_x_1) + 900 +(($x-spacer+$third-spacer)*$fn_x_2)}" y="{-500 - ($y-spacer * 4.5 *$fn_y_1) - (($y-spacer+$third-spacer)*$fn_y_2)}" text-anchor="middle" font-size="6">{$roman}</text>
                    (: KYW: Roman nodes :)
                    </g>
                    
                }   
                
            <g alignment-baseline="baseline" transform="translate(0, 0)">
          
            
            <circle r="20.5" cx="100" cy="-500" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
            <text x="100" y="-500" text-anchor="middle" font-size="6.5">Gallic Wars</text>    
            
            <circle r="20.5" cx="900" cy="-500" fill="#FFFFFF" stroke="#8a2b2b" stroke-dasharray="3"/>
            <text x="900" y="-500" text-anchor="middle" font-size="8">Civil War</text>
            (: KYW: hard-codes nodes :)
            
            {for $book in $g_books 
                let $num := $book/@num
                group by $num 
                return 
                    let $g_romans := $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    return $g_romans
                
                }
                
                (: KYW: WIP to get edges for Romans that appear in both sections; may abandon
            
            </g>
        </svg>
        </div>
        </p>
        <p>This diagram shows a list of distinct names of Romans for each book, separated into one half for the Gallic Wars, and the other for the Civil War. Edges from the 'book' nodes to the 'person' nodes are scaled to the number of times that specific Roman appears in the book. As an example of what we can extract from this, <a href="https://en.wikipedia.org/wiki/Gaius_Caninius_Rebilus_(consul_45_BC)">Gaius Caninius Rebilus (G. Caninius)</a> appears in 2/3 of the books in the Civil War section as well as books 7 and 8 of the Gallic Wars. Then, by looking at the text and researching online, we were able to confirm that Caninius made a name for himself during the <a href="https://en.wikipedia.org/wiki/Battle_of_Alesia">siege of Alesia</a>, then getting rewarded with a very brief consulship in 45 BCE.</p>
        <div class="kumu">
        <iframe src="https://embed.kumu.io/aa8b6bcc31ecd3afe39a612da28adbbc" width="940" height="600" frameborder="0"></iframe>
        <p>Test</p>
        </div>
        </div>
        </body>
        </html>