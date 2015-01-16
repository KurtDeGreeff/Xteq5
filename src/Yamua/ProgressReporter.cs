﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Yamua
{
    /// <summary>
    /// A helper class to report status using the IProgress interface and reporting back a class (which requires a default constructor).
    /// The object beeing reported can used only be ONCE. If RearmAfterReport is FALSE (the default), calling Report again will raise an exception.
    /// If Rearm is TRUE, a new instance of the reported object will automatically be assigned after using Report.
    /// </summary>
    /// <typeparam name="ReportedObject">The object beeing reported when calling Report()</typeparam>
    public class ProgressReporter<ReportedObject> where ReportedObject : class, new()
    {
        IProgress<ReportedObject> _iProgress;

        /// <summary>
        /// Provides access to the instance that is beeing reported as the "Progress"
        /// </summary>
        public ReportedObject Content { get; private set; }

        /// <summary>
        /// If TRUE, calling Report() will automatically create a new instance of the reported object
        /// </summary>
        public bool RearmAfterReport { get; set; }

        /// <summary>
        /// Create an instance of this class, requires the IProgress<Class> implementation that is used to report progress.
        /// </summary>
        /// <param name="IProgress">IProgress implementation used to report progress</param>
        public ProgressReporter(IProgress<ReportedObject> IProgress)
        {
            _iProgress = IProgress;
            Content = new ReportedObject();
        }

        /// <summary>
        /// Create an instance of this class, requires the IProgress<Class> implementation that is used to report progress.
        /// </summary>
        /// <param name="IProgress">IProgress implementation used to report progress</param>
        /// <param name="RearmAfterReport">TRUE if a new instance of Content should automatically be created after Report()</param>
        public ProgressReporter(IProgress<ReportedObject> IProgress, bool RearmAfterReport)
            : this(IProgress)
        {
            this.RearmAfterReport = RearmAfterReport;
        }

        /// <summary>
        /// Reports CONTENT back as progress. Can be used only ONCE if RearmAfterReport is FALSE.
        /// </summary>
        public void Report()
        {
            //MTH: We need to make sure that an instance of this class is used only once because ReportedObject might be used in a entire different thread. 
            //Quote from [Reporting Progress from Async Tasks](http://blog.stephencleary.com/2012/02/reporting-progress-from-async-tasks.html) by Stephen Cleary
            //"...it means you can’t modify the progress object after it’s passed to Report. It is an error to keep a single “current progress” object, update it, and repeatedly pass it to Report."
            if (Content != null)
            {
                if (_iProgress != null)
                {
                    _iProgress.Report(Content);
                }

                //Set Content to null no matter if we have an actual IProgress or not to avoid that a wrong use of this function is undetected.
                Content = null;

                //If rearm is set, create a new instance. 
                if (RearmAfterReport)
                {
                    Content = new ReportedObject();
                }
            }
            else
            {
                //Seems you didn't read the part about "USE IT ONLY ONCE".
                //Here's an exception for you.
                //You're welcome. 
                throw new InvalidOperationException("An instance of the reported object can only be used once");
            }
        }


    }
}