declare variable $caesar := doc("../xml/caesar_all_chapters.xml");
declare variable $xscale := 4;
declare variable $yspacer := 50;
declare variable $barHeight := 25;

let $tribes :=
                for $name in distinct-values($caesar//Q{}tribe/@name ! string())
                let $count := count($caesar//Q{}tribe[@name = $name])
                order by $count descending, $name
                return
                    <tribe>
                        <name>{$name}</name>
                        <count>{$count}</count>
                    </tribe>
            
            let $top5 := subsequence($tribes, 1, 5)
return            
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="450">
    <g transform="translate(50,50)">
        
        <text x="200" y="0" font-size="26" font-weight="bold">
            Top 5 Tribes Mentioned
        </text>
        
        <!-- axes -->
        <line x1="150" y1="50" x2="150" y2="350" stroke="black" stroke-width="2"/>
        <line x1="150" y1="350" x2="700" y2="350" stroke="black" stroke-width="2"/>
        
        {           
            for $tribe at $pos in $top5
            let $count := xs:integer($tribe//Q{}count)
            
            let $y := $pos * $yspacer + 30
            let $barWidth := $count * $xscale
            return
                <g>
                    <text x="75" y="{$y + 20}" font-size="18">{string($tribe/Q{}name)}</text>
                    
                    <rect x="150"
                          y="{$y}"
                          width="{$barWidth}"
                          height="{$barHeight}"
                          fill="darkred"
                          stroke="black"/>
                    
                    <text x="{150 + $barWidth + 10}"
                          y="{$y + 20}"
                          font-size="16">{$count}</text>
                </g>
        }
        
        <!-- scale labels -->
        <text x="150" y="370" font-size="14">0</text>
        <text x="250" y="370" font-size="14">25</text>
        <text x="350" y="370" font-size="14">50</text>
        <text x="450" y="370" font-size="14">75</text>
        <text x="550" y="370" font-size="14">100</text>
        <text x="650" y="370" font-size="14">125</text>
    </g>
</svg>