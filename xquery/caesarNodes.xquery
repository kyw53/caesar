declare option saxon:output "omit-xml-declaration=yes";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

concat("Label,Description,Section,Count&#xa;", string-join(

 for $book in $g_books
                  let $section := $book/parent::section/@part
                    let $num := $book/@num
                    group by $num 
                    order by $num
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    return (concat ($num, ",", $roman, ",", translate($section, "g", "G"), ",", $roman-count, "&#xa;"))
                    
        ),
        string-join(
        
        for $book in $c_books
                  let $section := $book/parent::section/@part
                    let $num := $book/@num
                    group by $num
                    return
                    for $roman at $pos in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
                    let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
                    return (concat ($num, ",", $roman, ",", translate($section, "c", "C"), ",", $roman-count, "&#xa;"))
                    
        
        )
        )