declare option saxon:output "omit-xml-declaration=yes";
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $g_books := $text//section[@part="gaul"]//book;
declare variable $c_books := $text//section[@part="civil"]//book;

for $book in $text
let $num := $book/@num
group by $num
return
    if ($num < 9)
     then
          
          let $num := $book/@num
          for $roman at $pos in $book//persName[data(@eth)="roman"]/data(@nameid)=>distinct-values()
          let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
          order by $num
          return
              (concat ($num, ", ", $roman, ", ", "Roman, ", $roman-count, "Gaul,", "&#xa;"))
    else 
     
        let $num := $book/@num
        for $roman at $pos in $book//persName[data(@eth)="roman"]/data(@nameid)=>distinct-values()
        let $roman-count := $book//Q{}persName[data(@nameid) = $roman] =>count()
        order by $num
        return
          (concat ($num, ", ", $roman, ", ", "Roman, ", $roman-count, "Civil, ", "&#xa;"))