declare option saxon:output "method=html";

<html>
    <head>
        <title>Tables</title>
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
        <h2>Wondering which Romans show up in Caesar's Commentaries?</h2>
        
                <table style="text-align:center">
                <tr><th>Order</th><th>Roman</th><th>Appearances</th></tr>
                {
                let $text := doc("../xml/caesar_all_chapters.xml")
                let $book := //book
                let $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values()
                for $roman at $pos in $romans
                let $roman-count := //persName[data(@nameid) = $roman] =>count()
                    (:where $roman-count > 2:)
                    order by $roman-count descending
                return <tr><td>{$pos}</td> <td>{$roman}</td> <td>{$roman-count}</td></tr>
         }</table>
         
         <h2>Table 2:</h2>
         <p>[Placeholder]</p>
         </div>
    </body>
</html>