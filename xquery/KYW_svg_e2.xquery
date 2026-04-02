declare variable $x-spacer := 45;
declare variable $y-spacer := 45;
declare variable $text := doc("../xml/caesar_all_chapters.xml");
declare variable $c_books := $text//section[@part="civil"]//book;


<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 -1000 1000 1000">
<desc>A rough draft for a network diagram showing the Romans mentioned in each book of both the Gallic Wars and the Civil War.</desc>
<g alignment-baseline="baseline" transform="translate(0, 0)">

    <circle r="20.5" cx="500" cy="-500" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="500" y="-500" text-anchor="middle" font-size="8">Caesar</text>
    <!-- KYW: first layer of nodes-->
    
    <circle r="20.5" cx="400" cy="-500" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="400" y="-500" text-anchor="middle" font-size="6.5">Gallic Wars</text>
    <line x1="500" x2="412.5" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="20.5" cx="600" cy="-500" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="600" y="-500" text-anchor="middle" font-size="8">Civil War</text>
    <line x1="500" x2="587.5" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
    <!-- KYW: second layer of nodes-->
    
    <circle r="12.5" cx="450" cy="-545" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="450" y="-545" text-anchor="middle" font-size="4">Book I</text>
    <line x1="400" x2="450" y1="-500" y2="-545" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="415" cy="-560" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="415" y="-560" text-anchor="middle" font-size="4">Book II</text>
    <line x1="400" x2="415" y1="-500" y2="-560" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="375" cy="-555" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="375" y="-555" text-anchor="middle" font-size="4">Book III</text>
    <line x1="400" x2="375" y1="-500" y2="-555" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="340" cy="-535" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="340" y="-535" text-anchor="middle" font-size="4">Book IV</text>
    <line x1="400" x2="340" y1="-500" y2="-535" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="325" cy="-500" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="325" y="-500" text-anchor="middle" font-size="4">Book V</text>
    <line x1="400" x2="325" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="340" cy="-465" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="340" y="-465" text-anchor="middle" font-size="4">Book VI</text>
    <line x1="400" x2="340" y1="-500" y2="-465" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="375" cy="-440" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="375" y="-440" text-anchor="middle" font-size="4">Book VII</text>
    <line x1="400" x2="375" y1="-500" y2="-440" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="415" cy="-435" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="415" y="-435" text-anchor="middle" font-size="4">Book VIII</text>
    <line x1="400" x2="415" y1="-500" y2="-435" stroke="#8a2b2b" opacity="25%"/>
    <!-- KYW: 3rd layer of nodes for left side -->
    
    <circle r="12.5" cx="620" cy="-560" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="620" y="-560" text-anchor="middle" font-size="4">Book I</text>
    <line x1="600" x2="620" y1="-500" y2="-560" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="675" cy="-500" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="675" y="-500" text-anchor="middle" font-size="4">Book II</text>
    <line x1="600" x2="675" y1="-500" y2="-500" stroke="#8a2b2b" opacity="25%"/>
    
    <circle r="12.5" cx="620" cy="-435" fill="none" stroke="#8a2b2b" stroke-dasharray="3"/>
    <text x="620" y="-435" text-anchor="middle" font-size="4">Book III</text>
    <line x1="600" x2="620" y1="-500" y2="-435" stroke="#8a2b2b" opacity="25%"/>
    <!-- KYW: 3rd layer of nodes for right side-->
    
   {
   
   let $g_books := $text/Q{}section[@part="gaul"]//Q{}book
   for $book in $g_books
   let $num := $book/@num
   group by $num
   order by $num
   return 
   for $roman in $book//Q{}persName[@eth="roman"]/data(@nameid)=>distinct-values()
   let $roman-count := //Q{}persName[data(@nameid) = $roman] =>count()
   return <g>
   <text x="100" y="-100">{$roman}</text>
   </g>
   
   }
</g>
</svg>