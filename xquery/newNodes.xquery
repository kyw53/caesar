declare option saxon:output "omit-xml-declaration=yes";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

concat("Label,Type,Description,Count&#xa;", string-join(
    let $books := $text//book
    for $book in $books
        let $romans := $book//persName[data(@eth)="roman"]
        let $num := $book/@num
        for $roman at $pos in $romans
        group by $num
        return
            for $roman in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
            let $in-book-count := $book//persName[data(@nameid) = $roman]=>count()
            return 
                (concat ($roman, ",", "Person,", $num, ",", $in-book-count, "&#xa;")) )
       ,
       string-join(
       let $books := $text//book
       for $book in $books
       let $num := $book/data(@num)
       let $section := $book/parent::section/data(@part)
       let $roman-count := $book//persName[@eth="roman"]=>count()
       return 
        concat(translate($section, "cg", "CG"), ",", "Book,", $num, ",", $roman-count, "&#xa;")
       )
       )