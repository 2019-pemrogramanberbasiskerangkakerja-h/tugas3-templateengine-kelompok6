<!DOCTYPE html>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>JS fitness #6: table sorting with JS and flexbox (WIP)</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>


  
  
      <style>
      /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
      @charset "UTF-8";
[data-sort-by='firstName'] [data-prop-name='firstName'], [data-sort-by='lastName'] [data-prop-name='lastName'], [data-sort-by='birth'] [data-prop-name='birth'] {
  background: rgba(0, 0, 128, 0.15);
  text-shadow: 0 1px #eee;
}
[data-sort-by='firstName'] [data-prop-name='firstName']:before, [data-sort-by='lastName'] [data-prop-name='lastName']:before, [data-sort-by='birth'] [data-prop-name='birth']:before {
  box-shadow: 0 0 .5em navy;
}
[data-sort-by='firstName'] .prop__name[data-prop-name='firstName'], [data-sort-by='lastName'] .prop__name[data-prop-name='lastName'], [data-sort-by='birth'] .prop__name[data-prop-name='birth'] {
  color: lightcyan;
}
[data-sort-by='firstName'] .prop__name[data-dir='1'][data-prop-name='firstName']:after, [data-sort-by='lastName'] .prop__name[data-dir='1'][data-prop-name='lastName']:after, [data-sort-by='birth'] .prop__name[data-dir='1'][data-prop-name='birth']:after {
  content: '▲';
}
[data-sort-by='firstName'] .prop__name[data-dir='-1'][data-prop-name='firstName']:after, [data-sort-by='lastName'] .prop__name[data-dir='-1'][data-prop-name='lastName']:after, [data-sort-by='birth'] .prop__name[data-dir='-1'][data-prop-name='birth']:after {
  content: '▼';
}

* {
  box-sizing: inherit;
}

body {
  background: #555;
  font: 1em/1.25 trebuchet ms, verdana, sans-serif;
  color: #fff;
}

table {
  box-sizing: border-box;
  overflow: hidden;
  margin: 4em auto;
  border-collapse: collapse;
  min-width: 23em;
  width: 70%;
  max-width: 56em;
  border-radius: .5em;
  box-shadow: 0 0 .5em #000;
}

thead {
  background: linear-gradient(#606062, #28262b);
  font-weight: 700;
  letter-spacing: 1px;
  text-transform: uppercase;
  cursor: pointer;
}

th {
  text-align: left;
}

tbody {
  display: flex;
  flex-direction: column;
  color: #000;
}

tr {
  display: block;
  overflow: hidden;
  width: 100%;
}

.odd {
  background: linear-gradient(#eeeeee 1px, #dddddd 1px, #cccccc calc(100% - 1px), #999999 calc(100% - 1px));
}

.even {
  background: linear-gradient(#eeeeee 1px, #bbbbbb 1px, #aaaaaa calc(100% - 1px), #999999 calc(100% - 1px));
}

[class*='prop__'] {
  float: left;
  position: relative;
  padding: .5em 1em;
  width: 40%;
}
[class*='prop__']:last-child {
  width: 20%;
}
[class*='prop__']:before {
  position: absolute;
  top: -.5em;
  right: 0;
  bottom: -5em;
  left: 0;
  content: "";
}
[class*='prop__']:after {
  position: absolute;
  right: .5em;
}

    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>

</head>

<body>

  <h1 style="font-size: 40; text-align: center;">Express-tl</h1>

<table>
  <thead>
    <tr>
      <th class='prop__name' data-prop-name='firstName'>Nama</th>
      <th class='prop__name' data-prop-name='lastName'>Email</th>
      <th class='prop__name' data-prop-name='birth'>Password</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
  
  

<script type="text/javascript">
    var table = document.querySelector('table'), 
    table_meta_container = table.querySelector('thead'), 
    table_data_container = table.querySelector('tbody'),
    data = [
  { 'firstName': '${d.name}', 'lastName': '${d.email ? d.email : ''}', 'birth': '${d.password ? d.password : ''}'}
], n = data.length;

var createTable = function(src) {
  var frag = document.createDocumentFragment(), 
      curr_item, curr_p;
  
  for(var i = 0; i < n; i++) {
    curr_item = document.createElement('tr');
    curr_item.classList.add(((i%2 === 0)?'odd':'even'));
    data[i].el = curr_item;
    
    for(var p in data[i]) {
      if(p !== 'el') {
        curr_p = document.createElement('td');
        curr_p.classList.add('prop__value');
        curr_p.dataset.propName = p;
        curr_p.textContent = data[i][p];
        curr_item.appendChild(curr_p)
      }
    }
    
    frag.appendChild(curr_item);
  }
  
  table_data_container.appendChild(frag);
};

var sortTable = function(entries, type, dir) {  
  entries.sort(function(a, b) { 
    if(a[type] < b[type]) return -dir;
    if(a[type] > b[type]) return dir;
    return 0;
  });
  
  table.dataset.sortBy = type;
  
  for(var i = 0; i < n; i++) {
    entries[i].el.style.order = i + 1;
    
    if((i%2 === 0 && entries[i].el.classList.contains('even')) || 
       (i%2 !== 0 && entries[i].el.classList.contains('odd'))) {
      entries[i].el.classList.toggle('odd');
      entries[i].el.classList.toggle('even');
    }
  }
};

createTable(data);

table_meta_container.addEventListener('click', function(e) {
  var t = e.target;
  
  if(t.classList.contains('prop__name')) {
    if(!t.dataset.dir) { t.dataset.dir = 1; }
    else { t.dataset.dir *= -1; }
    
    sortTable(data, t.dataset.propName, t.dataset.dir);
  }
}, false);
</script>




</body>

</html>
