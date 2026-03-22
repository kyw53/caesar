declare option saxon:output "omit-xml-declaration=yes";
let $book := //book
let $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values()
for $roman in $romans
let $roman-count := //persName[data(@nameid) = $roman] =>count()
return (concat ("In Caesar's Commentaries, the Roman ", $roman, " appears ", $roman-count, " times. &#xa;"))

