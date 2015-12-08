using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AGTEX_Licensor
{
    public partial class AGTEX_LicensorForm : Form
    {
        DateTime reg_date_time;
        DateTime exp_date_time;
        int Card_count;
        int reLicensed_index;


        public AGTEX_LicensorForm()
        {
            InitializeComponent();
            try
            {
                using (RegistryKey GCinstallkey = Registry.CurrentUser.OpenSubKey("GC_Punch"))
                {
                    if (GCinstallkey != null)
                    {
                        // Specify current condition of the license
                        licesnse_statusStrip.Text = "AGTEX Found..! ";
                        //licesnse_statusStrip.Text += "  Licensed : " + GCinstallkey.GetValue("LicenseType").ToString();
                        //reg_date_time = Convert.ToDateTime(GCinstallkey.GetValue("LicensedDate").ToString());
                        //exp_date_time = reg_date_time.AddDays(45);
                        //Card_count = Convert.ToInt32(GCinstallkey.GetValue("Total_Cards").ToString());

                        
                        //if (GCinstallkey.GetValue("Expired").ToString().Equals("Yes"))
                        //    licesnse_statusStrip.Text += "  Expired";
                        //else
                        //{
                        //    if (GCinstallkey.GetValue("LicenseType").ToString().Equals("Free"))
                        //        licesnse_statusStrip.Text += " and Expires on : " + exp_date_time.ToLongDateString();
                        //    else
                        //        licesnse_statusStrip.Text += " - Unlimited starting from " + reg_date_time.ToLongDateString();
                        //}

                    }
                    else
                    {
                        // Specify current condition of the license
                        licesnse_statusStrip.Text = "AGTEX Not Found..!     Please contact Gurubrahma Technologies.";
                    }
                }
            }
            catch (Exception ex)  //just for demonstration...it's always best to handle specific exceptions
            {
                //react appropriately
                licesnse_statusStrip.Text = "System didnot respond as intended..!"+ex.ToString();
            }
        }

        private void license_button_Click(object sender, EventArgs e)
        {
            try
            {
                using (RegistryKey GCinstallkey = Registry.CurrentUser.OpenSubKey("GC_Punch", true))
                {

                    //licesnse_statusStrip.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                    DateTime newExpiryDate = newexpdate_dateTimePicker.Value;
                    DateTime newRegistrationDate = newExpiryDate.AddDays(-45);
                    GCinstallkey.SetValue("LicensedDate", DateTime.Now.ToString("dd-MMM-yyyy"));
                    // remove this line after full payment
                    //if (GCinstallkey.GetValueNames().Contains("reLicensed"))
                    //{
                    //    if (GCinstallkey.GetValue("reLicensed").ToString().Equals("Free"))
                    //        licesnse_statusStrip.Text = "This AG Tex has already been Rearmed";
                    //    GCinstallkey.SetValue("reLicensed", "Free");
                    //    return;
                    //}
                    //else
                    //{
                    //    GCinstallkey.SetValue("reLicensed", "Free");
                    //}

                    if (expire_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "Yes");
                        licesnse_statusStrip.Text = " AGTEX License Expired ";

                    }
                    if (unlmtd_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "No");
                        //GCinstallkey.SetValue("Total_Cards", "0");
                        GCinstallkey.SetValue("LicensedDate", "26-Nov-2015");
                        licesnse_statusStrip.Text = " AGTEX License Premium - Unlimited starting from " + DateTime.Now.ToLongDateString();
                    }

                    if (trialreset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Total_Cards", "0");
                        GCinstallkey.SetValue("Expired", "No");
                        GCinstallkey.SetValue("LicensedDate", "26-Nov-2015");
                        licesnse_statusStrip.Text = " AGTEX License Free Trial starting from " + DateTime.Now.ToLongDateString();

                    }
                    if (datereset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "No");
                        //GCinstallkey.SetValue("Total_Cards", "0");
                        GCinstallkey.SetValue("LicensedDate", "26-Nov-2015");
                        licesnse_statusStrip.Text = " AGTEX License Trial re-extended till " + newExpiryDate.ToLongDateString();

                    }
                    if (cardreset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "No");
                        GCinstallkey.SetValue("Total_Cards", (100000-Convert.ToInt32(cards_textbox.Text)).ToString());
                        //GCinstallkey.SetValue("LicensedDate", DateTime.Now.ToString("dd-MMM-yyyy"));
                        GCinstallkey.SetValue("LicensedDate", "26-Nov-2015");
                        licesnse_statusStrip.Text = " AGTEX License Trial re-extended to " + cards_textbox.Text + " Cards";

                    }
                }
            }
            catch (Exception ex)  //just for demonstration...it's always best to handle specific exceptions
            {
                //react appropriately
                licesnse_statusStrip.Text = "System didnot respond as intended..!" + ex.ToString();
            }
        }

        private void expire_license_radioButton_CheckedChanged(object sender, EventArgs e)
        {
            if (expire_license_radioButton.Checked)
                license_button.Text = "De-License";
            else
                license_button.Text = "License";


        }

        private void datereset_license_radioButton_CheckedChanged(object sender, EventArgs e)
        {
            if (datereset_license_radioButton.Checked)
                newexpdate_dateTimePicker.Enabled = true;
            else
                newexpdate_dateTimePicker.Enabled = false;
        }

        private void cardreset_license_radioButton_CheckedChanged(object sender, EventArgs e)
        {
            if (cardreset_license_radioButton.Checked)
                cards_textbox.Enabled = true;
            else
                cards_textbox.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {

            try
            {
                using (RegistryKey GCinstallkey = Registry.CurrentUser.OpenSubKey("GC_Punch", true))
                {

                    //licesnse_statusStrip.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                    DateTime newExpiryDate = newexpdate_dateTimePicker.Value;
                    DateTime newRegistrationDate = newExpiryDate.AddDays(-45);
                    GCinstallkey.SetValue("LicensedDate", DateTime.Now.ToString("dd-MMM-yyyy"));
                    // remove this line after full payment
                    if (GCinstallkey.GetValueNames().Contains("reLicensed"))
                    {
                        if (GCinstallkey.GetValue("reLicensed").ToString().Equals("Free"))
                            licesnse_statusStrip.Text = "This AG Tex has already been Rearmed";
                        GCinstallkey.SetValue("reLicensed", "Free");
                        return;
                    }
                    else
                    {
                        GCinstallkey.SetValue("reLicensed", "Free");
                    }

                    if (expire_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "Yes");
                        licesnse_statusStrip.Text = " AGTEX License Expired ";

                    }
                    if (unlmtd_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Premium");
                        GCinstallkey.SetValue("Expired", "No");
                        licesnse_statusStrip.Text = " AGTEX License Premium - Unlimited starting from " + DateTime.Now.ToLongDateString();

                    }

                    if (trialreset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Total_Cards", "0");
                        GCinstallkey.SetValue("Expired", "No");
                        licesnse_statusStrip.Text = " AGTEX License Free Trial starting from " + DateTime.Now.ToLongDateString();

                    }
                    if (datereset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "No");
                        //GCinstallkey.SetValue("Total_Cards", "0");
                        GCinstallkey.SetValue("LicensedDate", newRegistrationDate.ToString("dd-MMM-yyyy"));
                        licesnse_statusStrip.Text = " AGTEX License Trial re-extended till " + newExpiryDate.ToLongDateString();

                    }
                    if (cardreset_license_radioButton.Checked)
                    {
                        GCinstallkey.SetValue("LicenseType", "Free");
                        GCinstallkey.SetValue("Expired", "No");
                        GCinstallkey.SetValue("Total_Cards", (100000 - Convert.ToInt32(cards_textbox.Text)).ToString());
                        //GCinstallkey.SetValue("LicensedDate", DateTime.Now.ToString("dd-MMM-yyyy"));
                        licesnse_statusStrip.Text = " AGTEX License Trial re-extended to " + cards_textbox.Text + " Cards";

                    }
                }
            }
            catch (Exception ex)  //just for demonstration...it's always best to handle specific exceptions
            {
                //react appropriately
                licesnse_statusStrip.Text = "System didnot respond as intended..!" + ex.ToString();
            }
        }
    }
}