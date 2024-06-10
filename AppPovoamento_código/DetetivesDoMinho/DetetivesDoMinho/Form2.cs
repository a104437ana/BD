using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DetetivesDoMinho
{
    public partial class Form2 : Form
    {
        public MySqlConnection con = new MySqlConnection();

        //strings com as instruções a executar e a mostrar ao utilizador
        public string cmdString1 = "INSERT INTO Testemunha(Nome, Telefone) VALUES\n('Bruno Correia Santos',351935851493),\n('Amanda Ribeiro Sousa',351916875305),\n('Marisa Cardoso Ferreira',351285420963),\n('Conceição Fernão Correia',351282047059),\n('Marcelo Victor Correia',351900513058),\n('Inês Vilmar Castelo',351278505486),\n('Susana Julieta Freitas',351250430780);";
        public string cmdString2 = "INSERT INTO Testemunha_de_Homicidio (Testemunha, Homicidio, Resumo_testemunho, Link_testemunho) VALUES\n('3','2','Enquanto passava pela igreja, ouviu pessoas a discutir','https://www.detetivesdominho.pt/login/testemunhos/t3/t3.pdf'),\n('4','2','Viu um homem a entrar na igreja por volta das 17 horas','https://www.detetivesdominho.pt/login/testemunhos/t4/t4.pdf'),\n('5','2','Viu um homem a sair da igreja e dirigir-se para um beco, por volta das 20 horas','https://www.detetivesdominho.pt/login/testemunhos/t5/t5.pdf'),\n('6','1','Encontrou a vítima morta no escritório e ligou para a polícia','https://www.detetivesdominho.pt/login/testemunhos/t6/t6.pdf'),\n('7','2','Enquanto colocava as flores da igreja, viu dois homens a conversar','https://www.detetivesdominho.pt/login/testemunhos/t7/t7.pdf'),\n('8','2','Encontrou a vítima morta na igreja e chamou a polícia','https://www.detetivesdominho.pt/login/testemunhos/t8/t8.pdf');";

        public Form2(MySqlConnection connection)
        {
            InitializeComponent();
            this.con = connection;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void executar_Click(object sender, EventArgs e)
        {
            try
            {
                //execução da 1ª instrução
                MySqlCommand cmd1 = new MySqlCommand(cmdString1, con);
                int linhas1 = cmd1.ExecuteNonQuery();
                output.Text = "Comando 1 executado com sucesso.\n"+linhas1+" linhas afetadas.\n";
            }

            catch (MySqlException ex1)
            {
                this.output.Text = ex1.ToString();
            }
            try
            {
                //execução da 2ª instrução
                MySqlCommand cmd2 = new MySqlCommand(cmdString2, con);
                int linhas2 = cmd2.ExecuteNonQuery();
                this.output.Text += "\nComando 2 executado com sucesso.\n" + linhas2 + " linhas afetadas.\n";
            }

            catch (MySqlException ex2)
            {
                this.output.Text += ("\n\n" + ex2.ToString());
            }
        }

        private void Form2_FormClosing_1(object sender, FormClosingEventArgs e)
        {
            //quando o utilizador sai deste menu, a ligação à base de dados é fechada
            con.Close();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            //mostra as instruções que vão ser executadas
            input.Text = cmdString1 + "\n\n" + cmdString2;
        }
    }
}
