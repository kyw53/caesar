declare namespace math = "http://www.w3.org/2005/xpath-functions/math";
    (: KYW: this is needed for the trig functions to build the nodes :)
declare variable $section := //section/data(@part);
    (: KYW: needed since we wanted to distinguish between the two texts:)
declare variable $x-spacer := 60;
declare variable $y-spacer := 45;
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
    (: KYW: creates list of books for gaul section :)
declare variable $c_books := $text//section[@part="civil"]//book;
<html>
    <head>
        <title>Network Diagrams</title>
        <link type="text/css" href="style.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="images/SPQR.svg"/>
    </head>
    <body>
        <nav>
            <div><a href="index.html">Home</a></div>
            <div><a href="background.html">Background</a></div>
            <div><a href="about.html">About</a></div>
            <div class="dropdown"><a href="#">Graphs and Data</a>
                <div class="dropdown-content">
                    <a href="network-output.html">Network Diagram</a>
                    <a href="ethnicity-count.html">Ethicity Count</a>
                    <a href="BarGraphLocations.html">Location Count</a>
                    <a href="CircleMapLocations.html">Map Graph</a>
                    <a href="CaesarMentionsBarGraph.html">Caesar Mentions</a>
                </div>
            </div>
        </nav>
        
    <div class="main-content">
    <h1>Divide et Impera</h1>
    <h2>Roman Network Diagrams</h2>
    <h3>XQuery-to-SVG</h3>
    <p>
        <div class="kyle-svg">
        <svg xmlns="http://www.w3.org/2000/svg" width="auto" height="auto" viewBox="-275 -850 1550 700">
            (: KYW: remember to use Q{} for elements in XPath statements in SVG portion :)
            <desc>A network graph</desc>
            {
            let $num := $text/Q{}book/(@num)
                (: KYW: grabs @num for math purposes :)
            for $book at $num in $g_books
            let $fn_x_1 := math:cos(40 * ($num))
                (: KYW: angle of 40 was achieved via: 360/(n+1) where n is the number of books/inner nodes; seemed to work okay, but may want to try something different  :)
            let $fn_y_1 := math:sin(40 * ($num) )
            return <g>
            <line x1="100" x2="{($x-spacer * 4.5 *$fn_x_1) + 100}" y1="-500" y2="{-500 - ($y-spacer * 4.5 *$fn_y_1)}" stroke="#7851A9" opacity="75%"/>
                (: KYW: constant of '4.5' should probably be removed and tweak x-spacer value :)
                (: KYW: edge from section node to book nodes :)
            
            
                
            </g>
            }
                {
                    
                    for $book in $g_books
                    let $num := $book/@num
                    group by $num
                        (: KYW: 'group by' needed since @num was returned as a series of values, I think? :)
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                        (: KYW: used $pos since the names aren't numbered or anything of the like :)
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    let $third-spacer := 5
                    let $fn_x_1 := math:cos(40 * ($num))
                    let $fn_x_2 := math:cos(36*($pos))
                        (: KYW: used a smaller angle since there were more nodes :)
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
                    (: KYW: nodes and text for books :)
                    
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
                        (: KYW: don't think we ended up using this, but could use it as the value of @r in <circle> to scale :)
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
                    (: KYW: edge from section node to Roman nodes :)
                    
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
            (: KYW: hard-coded nodes :)
            
          
            
            </g>
        </svg>
        </div>
        </p>
        <p>This diagram shows a list of distinct names of Romans for each book, separated into one half for the Gallic Wars and the other for the Civil War. Edges from the book nodes to the person nodes are scaled to the number of times that specific Roman appears in the book. As an example of what we can extract from this, <a href="https://en.wikipedia.org/wiki/Gaius_Caninius_Rebilus_(consul_45_BC)">Gaius Caninius Rebilus (G. Caninius)</a> appears in 2/3 of the books in the Civil War section as well as books 7 and 8 of the Gallic Wars. Then, by looking at the text and researching online, we were able to confirm that Caninius made a name for himself during the <a href="https://en.wikipedia.org/wiki/Battle_of_Alesia">siege of Alesia</a>, then being rewarded with a very brief consulship in 45 BCE.</p>
        <h3>Kumu</h3>
        <div class="kumu">
        <iframe src="https://embed.kumu.io/aa8b6bcc31ecd3afe39a612da28adbbc" height="600" frameborder="0"></iframe>
        </div>
        <p>This Kumu network diagram, similar to the one above, shows a distinct list of Romans for each book divided by the two sections, with the person nodes scaled to the number of appearances in a given book. We were having trouble getting the data from our edges CSV file to interface with the nodes, so we decided to just use one set of data with several added Fields to divide the books/sections. Now with this graph, we can see that a Roman like <a href="https://en.wikipedia.org/wiki/Titus_Labienus">Titus Labienus</a> was heavily mentioned in the Gallic Wars section, but not nearly as much in the latter. Then with research, we were able to uncover that Labienus seems to have dwindled in his support for Caesar, dying in resistance at <a href="https://en.wikipedia.org/wiki/Battle_of_Munda">Munda</a> in 45 BCE.</p>
        <h3>Comparison</h3>
        <p>With the SVG graph, we were able to get finer-grain control over the diagram, but it also required more effort. For instance, the locations of the person nodes use XPath's trigonometric functions, and their edges use the SVG &lt;path&gt; element. Therefore, we could customize things like the angle between the book and person nodes or make the edges a different type of curve, but both of those require more effort. With Kumu, we were able to get a viable output much quicker. On top of that, we used a field, called Name, to create connections for the person nodes across <i>all</i> of the books, which is something we wanted to do with the SVG graph, but couldn't figure out. That said, the Kumu graph has denser information, but it's also more cluttered, and we couldn't figure out how to change something simple like the background color.</p>
        </div>
        </body>
        </html>