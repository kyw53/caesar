let $chapter := //book
let $tribes := $chapter//tribe//data(@name)=> distinct-values()
let $tribe-count := $tribes => count()
for $char in $tribes
let $tribe-chapter-count := //book[.//tribe/data(@name) = $char] => count()
where $tribe-chapter-count >1
order by $tribe-chapter-count descending
return (concat ("&#xa;", "The ", $char, " tribe is mentioned in ", $tribe-chapter-count, " books."))