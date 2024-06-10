using MySql.Data.MySqlClient;
using System.Drawing;
namespace DetetivesDoMinho
{
    public partial class Form1 : Form
    {
        public MySqlConnection con = new MySqlConnection();
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //l� nome de utilizador e password inseridas
            string user = userName.Text;
            string password = this.password.Text;
            try
            {
                //liga��o � base de dados
                string connection = "server=localhost;user id=" + user + ";password=" + password + ";database=agenciadetetivesdb";
                con.ConnectionString = connection;
                con.Open();

                //limpa o texto inserido na password
                this.password.Text = "";

                //mostra o menu seguinte
                Form2 form = new Form2(con);
                form.Show();
            }
            catch (MySqlException ex)
            {
                //se n�o foi poss�vel ligar � base de dados, mostra a mensagem de erro ao utilizador e limpa o texto inserido na password
                MessageBox.Show(ex.ToString());
                this.password.Text = "";
                con.Close();
            }
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            //quando este menu � fechado fecha a liga��o � base de dados
            con.Close();
        }
    }
}
