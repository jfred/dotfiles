if (rs.ok == 0) {
   throw "replset not initialized"
}

primary = false;
rs.status().members.forEach(function(member){
   if (member.state == 1){
      primary = member;
   }
});

if (!primary){
   throw "replset has no master"
}
