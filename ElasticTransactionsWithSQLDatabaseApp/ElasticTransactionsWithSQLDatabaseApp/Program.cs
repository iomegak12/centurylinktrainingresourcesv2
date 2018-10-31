using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            var connStrDb1 = @"data source=iomegasqlserverv2.database.windows.net;user id=iomegaadmin;password=Prestige123;initial catalog=iomegasqldatabasev2;";
            var connStrDb2 = @"data source=iomegasqlserverv3.database.windows.net;user id=iomegaadmin;password=Prestige123;initial catalog=iomegasqldatabasev3;";

            using (var scope = new TransactionScope())
            {
                using (var conn1 = new SqlConnection(connStrDb1))
                {
                    conn1.Open();
                    SqlCommand cmd1 = conn1.CreateCommand();
                    cmd1.CommandText = string.Format("insert into DemoTable (field2) values('CenturyLink')");
                    cmd1.ExecuteNonQuery();
                }

                using (var conn2 = new SqlConnection(connStrDb2))
                {
                    conn2.Open();
                    var cmd2 = conn2.CreateCommand();
                    cmd2.CommandText = string.Format("insert into DemoTable (field2) values('CenturyLink')");
                    cmd2.ExecuteNonQuery();
                }

                scope.Complete();
            }

            Console.WriteLine("End of Application!");
            Console.ReadLine();
        }
    }
}
