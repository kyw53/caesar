declare option saxon:output "omit-xml-declaration=yes";
    (: KYW: needed to omit declaration for CSV output :)
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

concat("ID,Label,Type,Section,Count,Tags,Name&#xa;", string-join(
    (: KYW: ID is a unique name that's generated with XQuery; Label is the value of @nameid; Type originally distinguished between person/book, but I don't think it's necessary any more; Section is either Gaul or Civil; Count is the number of times that Roman appears in the given book; Tags groups them by book number; Name takes the value of @nameid again to create connections :)
    let $books := $text//book
    (: KYW: since we use Fields to grab the section, we don't have to divide between Gaul and Civil here :)
    for $book in $books
       
        let $romans := $book//persName[data(@eth)="roman"]
        let $num := $book/@num
        for $roman at $pos in $romans
        group by $num
        (: KYW: grabs every instance of a Roman, then groups them by book number :)
        return
            for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                (: KYW: then removes duplicates from the result :)
             let $section := $book/parent::section/@part
             let $id := concat($pos, $roman, $num)
                (: KYW: since this is supposed to be a truly unique ID for kumu, I chose these 3 values and stuck them together :)
            let $in-book-count := $book//persName[data(@nameid) = $roman]=>count()
            return 
                (concat ($id, ",", $roman, ",", "Person,", translate($section, "gc", "GC"), ",", $in-book-count, ",", "Book ", $num, ",", $roman, "&#xa;")) ))