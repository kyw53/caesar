declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";

declare variable $caesar := doc("../xml/caesar_all_chapters.xml");

<html>
   <head>
      <title>Tribe Appearance Count</title>
   </head>
   <body>
      <h1>Tribe Appearance Count</h1>
      <table border="1">
         <tr>
            <th>Tribe</th>
            <th>Appearances</th>
         </tr>
         {
            for $name in distinct-values($caesar//tribe/@name)
            let $count := count($caesar//tribe[@name = $name])
            where normalize-space($name) != ""
            order by $count descending, $name
            return
               <tr>
                  <td>{$name}</td>
                  <td>{$count}</td>
               </tr>
         }
      </table>
   </body>
</html>