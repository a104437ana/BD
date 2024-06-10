namespace DetetivesDoMinho
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            conectar = new Button();
            userName = new TextBox();
            password = new TextBox();
            label1 = new Label();
            label2 = new Label();
            SuspendLayout();
            // 
            // conectar
            // 
            conectar.BackColor = Color.LightBlue;
            conectar.FlatAppearance.BorderColor = Color.White;
            conectar.FlatAppearance.BorderSize = 0;
            conectar.Font = new Font("Segoe UI Semibold", 13.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            conectar.ForeColor = Color.DarkSlateGray;
            conectar.Location = new Point(562, 313);
            conectar.Name = "conectar";
            conectar.Size = new Size(328, 137);
            conectar.TabIndex = 0;
            conectar.Text = "Conectar à base de dados";
            conectar.UseVisualStyleBackColor = false;
            conectar.Click += button1_Click;
            // 
            // userName
            // 
            userName.Font = new Font("Segoe UI", 13.8F, FontStyle.Regular, GraphicsUnit.Point, 0);
            userName.Location = new Point(56, 322);
            userName.Name = "userName";
            userName.PlaceholderText = "Utilizador";
            userName.Size = new Size(276, 38);
            userName.TabIndex = 1;
            // 
            // password
            // 
            password.Font = new Font("Segoe UI", 13.8F, FontStyle.Regular, GraphicsUnit.Point, 0);
            password.Location = new Point(56, 395);
            password.Name = "password";
            password.PlaceholderText = "Password";
            password.Size = new Size(276, 38);
            password.TabIndex = 2;
            password.UseSystemPasswordChar = true;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 36F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.ForeColor = Color.DarkSlateGray;
            label1.Location = new Point(29, 46);
            label1.Name = "label1";
            label1.Size = new Size(587, 81);
            label1.TabIndex = 3;
            label1.Text = "Detetives do Minho";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI Semibold", 20.2F, FontStyle.Bold);
            label2.ForeColor = Color.FromArgb(64, 64, 64);
            label2.Location = new Point(31, 164);
            label2.Name = "label2";
            label2.Size = new Size(819, 46);
            label2.TabIndex = 4;
            label2.Text = "Insira as suas credenciais de acesso à base de dados";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.WhiteSmoke;
            ClientSize = new Size(986, 555);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(password);
            Controls.Add(userName);
            Controls.Add(conectar);
            Name = "Form1";
            Text = "Detetives do Minho";
            FormClosing += Form1_FormClosing;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button conectar;
        private TextBox userName;
        private TextBox password;
        private Label label1;
        private Label label2;
    }
}
