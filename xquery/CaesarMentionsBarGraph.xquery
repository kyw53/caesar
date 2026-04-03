declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";

declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $xspacer := 6;
declare variable $yspacer := 20;

<html>
    <head>
        <title>Tables</title>
        <link type="text/css" href="../docs/style.css" rel="stylesheet" />
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
        <h2>In which book is Caesar mentioned the most the most times?</h2>
        
<svg xmlns="http://www.w3.org/2000/svg" width="1300" height="1000">
    <g transform="translate(60,0)">

    <g>
        {
            let $books :=$text//Q{}book
            for $book at $pos in $books
            let $caesar-count := $book//Q{}persName[@nameid="Caesar"] =>count()
                
            return
                <g>
                <!-- x axis-->
                <line x1="0" 
                    y1="0" 
                    x2="1200" 
                    y2="0" 
                    stroke="black" 
                    stroke-width="2"/>
                    
                <!--y axis-->
                <line x1="0" 
                    y1="0" 
                    x2="0" 
                    y2="{20 + ($pos * $yspacer)}" 
                    stroke="black" 
                    stroke-width="2"/>
                    
                <!--bar label-->
                <text x="-20" 
                    y="{$pos * $yspacer + 5}" 
                    font-size="12px" 
                    fill="black"
                    text-anchor="end"
                    dominant-baseline="middle">Book {$pos}</text>
                    
                <!--bars-->
                <line x1="0" 
                    y1="{$pos * $yspacer}" 
                    x2="{$caesar-count * $xspacer}" 
                    y2="{$pos * $yspacer}" 
                    stroke="#6B1F1F" 
                    fill="none" 
                    stroke-width="15"/>
                
                <!--- count label -->
                <text x="{$caesar-count * $xspacer + 10}" 
                    y="{$pos * $yspacer + 5}" 
                    font-family="sans-serif" 
                    font-size="12px" 
                    fill="black">{$caesar-count}</text>
                
                </g>
        }
        </g>
    </g>
</svg>
        
        </div>
        <div>
        <p>This table tries to explore how many times Ceasar is mentioned in each book and to find a dynamic in it</p>
        
        </div>
        </body>
        </html>