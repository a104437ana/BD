namespace DetetivesDoMinho
{
    partial class Form2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            executar = new Button();
            label1 = new Label();
            label2 = new Label();
            voltar = new Button();
            output = new Label();
            input = new Label();
            SuspendLayout();
            // 
            // executar
            // 
            executar.BackColor = Color.LightBlue;
            executar.FlatAppearance.BorderColor = Color.White;
            executar.FlatAppearance.BorderSize = 0;
            executar.Font = new Font("Segoe UI Semibold", 13.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            executar.ForeColor = Color.DarkSlateGray;
            executar.Location = new Point(210, 470);
            executar.Name = "executar";
            executar.Size = new Size(221, 73);
            executar.TabIndex = 1;
            executar.Text = "Executar instruções";
            executar.UseVisualStyleBackColor = false;
            executar.Click += executar_Click;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI Semibold", 14F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.ForeColor = Color.FromArgb(64, 64, 64);
            label1.Location = new Point(201, 9);
            label1.Name = "label1";
            label1.Size = new Size(246, 32);
            label1.TabIndex = 3;
            label1.Text = "Instruções a executar";
            label1.Click += label1_Click;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI Semibold", 14F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label2.ForeColor = Color.FromArgb(64, 64, 64);
            label2.Location = new Point(770, 9);
            label2.Name = "label2";
            label2.Size = new Size(92, 32);
            label2.TabIndex = 6;
            label2.Text = "Output";
            // 
            // voltar
            // 
            voltar.BackColor = Color.LightBlue;
            voltar.FlatAppearance.BorderColor = Color.White;
            voltar.FlatAppearance.BorderSize = 0;
            voltar.Font = new Font("Segoe UI Semibold", 13.8F, FontStyle.Bold, GraphicsUnit.Point, 0);
            voltar.ForeColor = Color.DarkSlateGray;
            voltar.Location = new Point(866, 470);
            voltar.Name = "voltar";
            voltar.Size = new Size(108, 73);
            voltar.TabIndex = 4;
            voltar.Text = "Voltar";
            voltar.UseVisualStyleBackColor = false;
            voltar.Click += button1_Click;
            // 
            // output
            // 
            output.BackColor = Color.Honeydew;
            output.BorderStyle = BorderStyle.FixedSingle;
            output.Location = new Point(654, 55);
            output.Name = "output";
            output.Size = new Size(320, 403);
            output.TabIndex = 7;
            // 
            // input
            // 
            input.BackColor = Color.Honeydew;
            input.BorderStyle = BorderStyle.FixedSingle;
            input.Font = new Font("Segoe UI", 7.8F, FontStyle.Regular, GraphicsUnit.Point, 0);
            input.Location = new Point(12, 55);
            input.Name = "input";
            input.Size = new Size(619, 403);
            input.TabIndex = 8;
            // 
            // Form2
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.WhiteSmoke;
            ClientSize = new Size(986, 555);
            Controls.Add(input);
            Controls.Add(output);
            Controls.Add(label2);
            Controls.Add(voltar);
            Controls.Add(label1);
            Controls.Add(executar);
            Name = "Form2";
            Text = "Detetives do Minho";
            FormClosing += Form2_FormClosing_1;
            Load += Form2_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button executar;
        private Label label1;
        private Label label2;
        private Button voltar;
        private Label output;
        private Label input;
    }
}