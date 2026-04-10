declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $x-spacer := 90;
declare variable $y-spacer := 35;
<html>
    <head>
        <title>Exercise 3</title>
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
    <h2>Page</h2>
    <h3>Text</h3>
    <p>
        <div class="kyle-svg">
        <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 -770 825 825">
            <desc>A rough draft for a network diagram showing the Romans mentioned in each book of both the Gallic Wars and the Civil War.</desc>
            <g alignment-baseline="baseline" transform="translate(175, -750)">
            {
            let $g_books := $text//Q{}section[@part="gaul"]//Q{}book
            for $book in $g_books
            let $num := $book/@num
            group by $num 
            return
            for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
            let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
            return <g>
            <text x="{($pos*$x-spacer)-250}" y="{($num*$y-spacer)}" font-size="4">{$roman} appears {$roman-count} times in Book {$num}</text>
            </g>
            }
            </g>
        </svg>
        </div>
        </p>
        </div>
    </body>
</html>