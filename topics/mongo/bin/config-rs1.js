hostname = "127.0.0.1";
rsconf = {
 _id: "rs1",
 members: [
   {
     _id: 0,
     host: hostname+":27030"
   },
   {
     _id: 1,
     host: hostname+":27031"
   },
   {
     _id: 2,
     host: hostname+":27032"
   }
 ]
};

rs.initiate(rsconf);

print(tojson(rs.conf()));
print(tojson(rs.status()));
