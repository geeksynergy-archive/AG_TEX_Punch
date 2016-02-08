namespace AGTEX_Licensor
{
    partial class AGTEX_LicensorForm
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
            this.newexpdate_dateTimePicker = new System.Windows.Forms.DateTimePicker();
            this.LicesnseRadiobuttons_groupBox = new System.Windows.Forms.GroupBox();
            this.unlmtd_license_radioButton = new System.Windows.Forms.RadioButton();
            this.trialreset_license_radioButton = new System.Windows.Forms.RadioButton();
            this.label1 = new System.Windows.Forms.Label();
            this.cards_textbox = new System.Windows.Forms.TextBox();
            this.cardreset_license_radioButton = new System.Windows.Forms.RadioButton();
            this.datereset_license_radioButton = new System.Windows.Forms.RadioButton();
            this.expire_license_radioButton = new System.Windows.Forms.RadioButton();
            this.licesnse_statusStrip_holder = new System.Windows.Forms.StatusStrip();
            this.licesnse_statusStrip = new System.Windows.Forms.ToolStripStatusLabel();
            this.license_button = new System.Windows.Forms.Button();
            this.LicesnseRadiobuttons_groupBox.SuspendLayout();
            this.licesnse_statusStrip_holder.SuspendLayout();
            this.SuspendLayout();
            // 
            // newexpdate_dateTimePicker
            // 
            this.newexpdate_dateTimePicker.Enabled = false;
            this.newexpdate_dateTimePicker.Location = new System.Drawing.Point(150, 39);
            this.newexpdate_dateTimePicker.Name = "newexpdate_dateTimePicker";
            this.newexpdate_dateTimePicker.Size = new System.Drawing.Size(155, 20);
            this.newexpdate_dateTimePicker.TabIndex = 0;
            // 
            // LicesnseRadiobuttons_groupBox
            // 
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.unlmtd_license_radioButton);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.trialreset_license_radioButton);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.label1);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.cards_textbox);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.cardreset_license_radioButton);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.datereset_license_radioButton);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.expire_license_radioButton);
            this.LicesnseRadiobuttons_groupBox.Controls.Add(this.newexpdate_dateTimePicker);
            this.LicesnseRadiobuttons_groupBox.Location = new System.Drawing.Point(12, 4);
            this.LicesnseRadiobuttons_groupBox.Name = "LicesnseRadiobuttons_groupBox";
            this.LicesnseRadiobuttons_groupBox.Size = new System.Drawing.Size(322, 121);
            this.LicesnseRadiobuttons_groupBox.TabIndex = 2;
            this.LicesnseRadiobuttons_groupBox.TabStop = false;
            this.LicesnseRadiobuttons_groupBox.Text = "Licensing Category";
            // 
            // unlmtd_license_radioButton
            // 
            this.unlmtd_license_radioButton.AutoSize = true;
            this.unlmtd_license_radioButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.unlmtd_license_radioButton.Location = new System.Drawing.Point(76, 89);
            this.unlmtd_license_radioButton.Name = "unlmtd_license_radioButton";
            this.unlmtd_license_radioButton.Size = new System.Drawing.Size(200, 29);
            this.unlmtd_license_radioButton.TabIndex = 7;
            this.unlmtd_license_radioButton.Text = "Unlimited License";
            this.unlmtd_license_radioButton.UseVisualStyleBackColor = true;
            // 
            // trialreset_license_radioButton
            // 
            this.trialreset_license_radioButton.AutoSize = true;
            this.trialreset_license_radioButton.Checked = true;
            this.trialreset_license_radioButton.Location = new System.Drawing.Point(141, 19);
            this.trialreset_license_radioButton.Name = "trialreset_license_radioButton";
            this.trialreset_license_radioButton.Size = new System.Drawing.Size(175, 17);
            this.trialreset_license_radioButton.TabIndex = 6;
            this.trialreset_license_radioButton.TabStop = true;
            this.trialreset_license_radioButton.Text = "Reset Trial Duration from Today";
            this.trialreset_license_radioButton.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(260, 67);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(34, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Cards";
            // 
            // cards_textbox
            // 
            this.cards_textbox.Enabled = false;
            this.cards_textbox.Location = new System.Drawing.Point(150, 64);
            this.cards_textbox.Name = "cards_textbox";
            this.cards_textbox.Size = new System.Drawing.Size(104, 20);
            this.cards_textbox.TabIndex = 4;
            this.cards_textbox.Text = "100000";
            // 
            // cardreset_license_radioButton
            // 
            this.cardreset_license_radioButton.AutoSize = true;
            this.cardreset_license_radioButton.Location = new System.Drawing.Point(6, 65);
            this.cardreset_license_radioButton.Name = "cardreset_license_radioButton";
            this.cardreset_license_radioButton.Size = new System.Drawing.Size(138, 17);
            this.cardreset_license_radioButton.TabIndex = 3;
            this.cardreset_license_radioButton.Text = "Extend the Card Limt to ";
            this.cardreset_license_radioButton.UseVisualStyleBackColor = true;
            this.cardreset_license_radioButton.CheckedChanged += new System.EventHandler(this.cardreset_license_radioButton_CheckedChanged);
            // 
            // datereset_license_radioButton
            // 
            this.datereset_license_radioButton.AutoSize = true;
            this.datereset_license_radioButton.Location = new System.Drawing.Point(6, 42);
            this.datereset_license_radioButton.Name = "datereset_license_radioButton";
            this.datereset_license_radioButton.Size = new System.Drawing.Size(110, 17);
            this.datereset_license_radioButton.TabIndex = 2;
            this.datereset_license_radioButton.Text = "Extend License till";
            this.datereset_license_radioButton.UseVisualStyleBackColor = true;
            this.datereset_license_radioButton.CheckedChanged += new System.EventHandler(this.datereset_license_radioButton_CheckedChanged);
            // 
            // expire_license_radioButton
            // 
            this.expire_license_radioButton.AutoSize = true;
            this.expire_license_radioButton.Location = new System.Drawing.Point(6, 19);
            this.expire_license_radioButton.Name = "expire_license_radioButton";
            this.expire_license_radioButton.Size = new System.Drawing.Size(94, 17);
            this.expire_license_radioButton.TabIndex = 1;
            this.expire_license_radioButton.Text = "Expire License";
            this.expire_license_radioButton.UseVisualStyleBackColor = true;
            this.expire_license_radioButton.CheckedChanged += new System.EventHandler(this.expire_license_radioButton_CheckedChanged);
            // 
            // licesnse_statusStrip_holder
            // 
            this.licesnse_statusStrip_holder.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.licesnse_statusStrip});
            this.licesnse_statusStrip_holder.Location = new System.Drawing.Point(0, 129);
            this.licesnse_statusStrip_holder.Name = "licesnse_statusStrip_holder";
            this.licesnse_statusStrip_holder.Size = new System.Drawing.Size(468, 22);
            this.licesnse_statusStrip_holder.TabIndex = 3;
            this.licesnse_statusStrip_holder.Text = "Your edition of AGTEX has expired";
            // 
            // licesnse_statusStrip
            // 
            this.licesnse_statusStrip.Name = "licesnse_statusStrip";
            this.licesnse_statusStrip.Size = new System.Drawing.Size(0, 17);
            // 
            // license_button
            // 
            this.license_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.license_button.Location = new System.Drawing.Point(340, 12);
            this.license_button.Name = "license_button";
            this.license_button.Size = new System.Drawing.Size(127, 113);
            this.license_button.TabIndex = 4;
            this.license_button.Text = "License";
            this.license_button.UseVisualStyleBackColor = true;
            this.license_button.Click += new System.EventHandler(this.button1_Click);
            // 
            // AGTEX_LicensorForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(468, 151);
            this.Controls.Add(this.license_button);
            this.Controls.Add(this.licesnse_statusStrip_holder);
            this.Controls.Add(this.LicesnseRadiobuttons_groupBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "AGTEX_LicensorForm";
            this.Text = "AGTEX_Licensor";
            this.TopMost = true;
            this.LicesnseRadiobuttons_groupBox.ResumeLayout(false);
            this.LicesnseRadiobuttons_groupBox.PerformLayout();
            this.licesnse_statusStrip_holder.ResumeLayout(false);
            this.licesnse_statusStrip_holder.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker newexpdate_dateTimePicker;
        private System.Windows.Forms.GroupBox LicesnseRadiobuttons_groupBox;
        private System.Windows.Forms.RadioButton unlmtd_license_radioButton;
        private System.Windows.Forms.RadioButton trialreset_license_radioButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox cards_textbox;
        private System.Windows.Forms.RadioButton cardreset_license_radioButton;
        private System.Windows.Forms.RadioButton datereset_license_radioButton;
        private System.Windows.Forms.RadioButton expire_license_radioButton;
        private System.Windows.Forms.StatusStrip licesnse_statusStrip_holder;
        private System.Windows.Forms.ToolStripStatusLabel licesnse_statusStrip;
        private System.Windows.Forms.Button license_button;
    }
}

