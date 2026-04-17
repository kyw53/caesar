declare option saxon:output "omit-xml-declaration=yes";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

concat("ID,Label,Type,Description,Count&#xa;", string-join(
    let $books := $text//book
    for $book in $books
        let $romans := $book//persName[data(@eth)="roman"]
        let $num := $book/@num
        for $roman at $pos in $romans
        group by $num
        return
            for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
            let $id := concat($pos, $roman, $num)
            let $in-book-count := $book//persName[data(@nameid) = $roman]=>count()
            return 
                (concat ($id, ",", $roman, ",", "Person,", "Book ", $num, ",", $in-book-count, "&#xa;")) )
       ,
       string-join(
       let $books := $text//book
       for $book at $pos in $books
       let $num := $book/data(@num)
       let $section := $book/parent::section/data(@part)
       let $roman-count := $book//persName[@eth="roman"]=>count()
       let $id := concat("book", $pos, $num)
       return 
        concat($id, ",", "Book", ",", "subdiv,", "Book ", $num, ",", $roman-count, "&#xa;")
       )
       )