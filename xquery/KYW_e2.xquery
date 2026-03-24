declare option saxon:output "omit-xml-declaration=yes";
let $text := doc("../xml/caesar_all_chapters.xml")
let $book := //book
let $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values()
for $roman in $romans
let $roman-count := //persName[data(@nameid) = $roman] =>count()
order by $roman-count descending
return (concat ("In Caesar's Commentaries, the Roman ", $roman, " appears ", $roman-count, " times. &#xa;"))

