declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $xspacer := 10;
declare variable $yspacer := 25;
declare variable $book := $text//book;
declare variable $booknNum := $book/data(@num);
declare variable $romans := $book//persName[@eth="roman"]/data(@nameid)=>distinct-values();

<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
    <g transform="translate(150,100)">
    <g>
    <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black">Which people show up in Caesar's Commentaries the most times?</text>
    </g>
    <g>
        
        {
            for $roman at $pos in $romans
            let $roman-count := $text//Q{}persName[data(@nameid) = $roman] =>count()
                
            return
                <g>
                <line x1="0" y1="0" x2="{($pos+1)*$yspacer}" y2="0" stroke="black" stroke-width="2"/>
                <text x="-75" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$roman}</text>
                <line x1="0" y1="{$pos * $yspacer}" x2="{$roman-count * $xspacer}" y2="{$pos * $yspacer}" stroke="red" fill="none" stroke-width="15"/>
                <text x="{$roman-count * $xspacer + 10}" y="{$pos * $yspacer + 5}" font-family="sans-serif" font-size="12px" fill="black">{$roman-count}</text>
                <line x1="0" y1="0" x2="0" y2="{$roman-count* $yspacer}" stroke="black" stroke-width="2"/>
                </g>
        }
        </g>
    </g>
</svg>