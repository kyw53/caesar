declare variable $caesar := doc("../xml/caesar_all_chapters.xml");
declare variable $xscale := 4;
declare variable $yspacer := 30;
declare variable $barHeight := 25;

<html>
    <head>
        <title>Page 5</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        <h2>The most mentioned ethinicieties in each book by percentage(%)</h2>
        {
        let $books := $caesar//Q{}book
        let $bookCount := count($books)
        let $sectionHeight := 250
        
        return
        <svg xmlns="http://www.w3.org/2000/svg" width="750" height="{($bookCount * $sectionHeight) + 50}">
        {
            for $book at $bpos in $books[data(@num)<9]
            let $booknum := xs:integer($book/@num)
            let $offset := ($bpos - 1) * $sectionHeight
            
            let $top5 :=
                for $ethnicity in distinct-values($book//Q{}persName/@eth)
                let $count := count($book//Q{}persName/@eth[string() = $ethnicity])div count($book//Q{}persName)
                (:       I tried to use round() function but it only rounded the highest value to 100%         :)
                order by $count descending, $ethnicity
                return
                    map {
                        "name": $ethnicity,
                        "count": $count
                    }
        
            return
                <g transform="translate(0, {$offset})">
                    <!-- graph title -->
                    <text x="100" y="30" font-size="18" font-weight="bold">
                        Book {$booknum}
                    </text>
                    
                    <!-- axis -->
                    <line x1="150" y1="60" x2="150" y2="225" stroke="black" stroke-width="2"/>
                    
                    <!-- bars and labels-->
                    {
                        for $place at $pos in subsequence($top5, 1, 5)
                        let $count := $place?count
                        let $name := $place?name
                        let $y := 70 + (($pos - 1) * $yspacer)
                        let $barWidth := $count * $xscale*100
                        return
                            <g>
                                <text x="140"
                                      y="{$y + ($barHeight div 2)}"
                                      font-size="18"
                                      text-anchor="end"
                                      dominant-baseline="middle">{$name}</text>
                                
                                <rect x="150"
                                      y="{$y}"
                                      width="{$barWidth}"
                                      height="{$barHeight}"
                                      fill="darkred"
                                      stroke="black"/>
                                
                                <text x="{150 + $barWidth + 10}"
                                      y="{$y + 18}"
                                      font-size="16">{round-half-to-even($count*100, 2)} %</text>
                            </g>
                    }
                    
                </g>
        }
        </svg>
        }
        <p>This colection of graphs is aimed at analyzing how frequently </p>
        </div>
    </body>
</html>