using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace Edubill.YoShin.Common
{
    public class CommonControlFacade
    {
        // Implements the manual sorting of items by columns.
        private class ListViewItemComparer : IComparer
        {
            private int col;
            private SortOrder sortOrder;
            public ListViewItemComparer()
            {
                col = 0;
            }
            public ListViewItemComparer(int column, SortOrder Order)
                : this(column)
            {
                sortOrder = Order;
            }

            public ListViewItemComparer(int column)
            {
                col = column;
            }

            public int Compare(object x, object y)
            {
                try
                {
                    if (sortOrder != SortOrder.Descending)
                        return String.Compare(((ListViewItem)x).SubItems[col].Text, ((ListViewItem)y).SubItems[col].Text);
                    else
                        return String.Compare(((ListViewItem)y).SubItems[col].Text, ((ListViewItem)x).SubItems[col].Text);
                }
                catch
                {
                    return 0;
                }
            }
        }

        public static bool lvwSortColumn(ListView lvwTarget, int ColIndex, SortOrder sr)
        {
            try
            {
                lvwTarget.Sorting = sr;
                lvwTarget.ListViewItemSorter = new ListViewItemComparer(ColIndex, lvwTarget.Sorting);
                lvwTarget.Sort();
                lvwTarget.ListViewItemSorter = null;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool lvwFocusItem(ListViewItem item)
        {
            //item.ListView.SelectedItems.Clear();
            item.EnsureVisible();
            //item.Selected = true;

            return true;
        }
        public static bool lvwSortColumn(ListView lvwTarget, int ColIndex)
        {
            try
            {
                lvwTarget.Sorting = (lvwTarget.Sorting == SortOrder.Descending) ? SortOrder.Ascending : SortOrder.Descending;
                lvwTarget.ListViewItemSorter = new ListViewItemComparer(ColIndex, lvwTarget.Sorting);
                lvwTarget.Sort();
                //				lvwTarget.ListViewItemSorter = null;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static void lvwSetHeader(ListView lvwTarget, string header, ImageList imgList)
        {
            lvwTarget.LargeImageList = imgList;
            lvwTarget.SmallImageList = imgList;

            lvwSetHeader(lvwTarget, header);
        }

        public static string lvwDisplayColWidth(ListView lvwTarget)
        {
            string strTemp = "";

            foreach (ColumnHeader oHeader in lvwTarget.Columns)
            {
                strTemp += "Col[" + oHeader.Index.ToString() + "] = " + oHeader.Width.ToString() + "\r\n";
            }

            return strTemp;
        }

        public static void lvwSetHeader(ListView lvwTarget, string header)
        {
            string[] aHeader = header.Split('|');
            string[] aField;

            ColumnHeader oHeader;
            lvwTarget.View = View.Details;
            lvwTarget.FullRowSelect = true;
            lvwTarget.Columns.Clear();
            foreach (string item in aHeader)
            {
                aField = item.Split('#');
                oHeader = new ColumnHeader();
                oHeader.Text = aField[0];
                if (aField.Length > 1) oHeader.Width = int.Parse(aField[1]);
                lvwTarget.Columns.Add(oHeader);
            }
        }
        public static bool lvwSetBackColor(ListViewItem oItem, Color vColor)
        {
            try
            {
                oItem.BackColor = Color.LightGreen;
                foreach (ListViewItem.ListViewSubItem oSubItem in oItem.SubItems)
                {
                    oSubItem.BackColor = vColor;
                }
                oItem.UseItemStyleForSubItems = false;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static void lvwResizeLastCol(ListView lvwTarget)
        {
            try
            {
                int ColWidth = 0;

                if (lvwTarget.Columns.Count <= 1) return;

                for (int i = 0; i < lvwTarget.Columns.Count - 1; i++)
                {
                    ColWidth += lvwTarget.Columns[i].Width;
                }

                lvwTarget.Columns[lvwTarget.Columns.Count - 1].Width = lvwTarget.Width - ColWidth - 25;
            }
            catch
            {
            }
        }

        public static int lvwSelCount(ListView lvwTarget)
        {
            return lvwTarget.SelectedItems.Count;
        }

        public static ListViewItem lvwSetData(ListView lvwTarget, string vData)
        {
            return lvwSetData(lvwTarget, vData, "");
        }

        public static ListViewItem lvwSetData(ListView lvwTarget, string vData, string ImageKey)
        {
            return lvwSetData(lvwTarget, vData, ImageKey, null, -1);
        }
        public static ListViewItem lvwSetData(ListView lvwTarget, string vData, string ImageKey, object Tag)
        {
            return lvwSetData(lvwTarget, vData, ImageKey, Tag,-1);
        }
        public static ListViewItem lvwSetData(ListView lvwTarget, string vData, string ImageKey, object Tag, int index)
        {
            try
            {
                string[] aData = vData.Split('|');
                ListViewItem oItem;

                if (index < 0 || index >= lvwTarget.Items.Count)
                    oItem = lvwTarget.Items.Add(aData[0]);
                else
                    oItem = lvwTarget.Items.Insert(index, aData[0]);

                if (ImageKey != "") oItem.ImageKey = ImageKey;

                if (aData.Length > 1)
                {
                    for (int i = 1; i < aData.Length; i++)
                    {
                        oItem.SubItems.Add(aData[i]);
                    }
                }

                oItem.Tag = Tag;
                return oItem;
            }
            catch
            {
                return null;
            }
        }
    }
}
