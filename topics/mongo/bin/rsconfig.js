hostname = "127.0.0.1";
rsconf = {
 _id: "rs0",
 members: [
   {
     _id: 0,
     host: hostname+":27017"
   },
   {
     _id: 1,
     host: hostname+":27018"
   },
   {
     _id: 2,
     host: hostname+":27019"
   }
 ]
};

rs.initiate(rsconf);

print(tojson(rs.conf()));
print(tojson(rs.status()));
