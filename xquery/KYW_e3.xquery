(:declare option saxon:output "omit-xml-declaration=yes";
let $text := doc("../xml/caesar_all_chapters.xml")
let $book := //book
let $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values()
for $roman in $romans
let $roman-count := //persName[data(@nameid) = $roman] =>count()
order by $roman-count descending
return (concat ("In Caesar's Commentaries, the Roman ", $roman, " appears ", $roman-count, " times. &#xa;")):)

declare option saxon:output "method=html";

<html>
    <head>
        <title>Roman Appearance Count</title>
    </head>
    
    <body>
        <h1>Roman Appearance Count</h1>
        <p>Wondering which Romans show up in Caesar's Commentaries?</p>
        
                <table>
                <tr><th>Order</th><th>Roman</th><th>Appearances</th></tr>
                {
                let $text := doc("../xml/caesar_all_chapters.xml")
                let $book := //book
                let $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values()
                for $roman at $pos in $romans
                let $roman-count := //persName[data(@nameid) = $roman] =>count()
                    (:where $roman-count > 2:)
                    order by $roman-count descending
                (:return<li>{(concat("In Caesar's Commentaries, the Roman ", $roman, " appears ", $roman-count, " times."))}</li>:)
                return <tr><td>{$pos}</td> <td>{$roman}</td> <td>{$roman-count}</td></tr>
         }</table>
    </body>
</html>
