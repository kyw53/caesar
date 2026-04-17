declare option saxon:output "omit-xml-declaration=yes";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

concat("Label,Description,Count&#xa;", string-join(
    let $romans := $text//persName[data(@eth)="roman"]
    let $book := $text//book
        for $roman in $romans
        let $book-count := $book//persName[data(@nameid) = $roman]=>count()
        let $num := $book/data(@num)
        return
        for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
        return (concat ($num, ",", $roman, ",", $book-count, "&#xa;")) )
   )