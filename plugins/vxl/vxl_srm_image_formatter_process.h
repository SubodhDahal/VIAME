/*ckwg +29
 * Copyright 2019 by Kitware, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 *  * Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 *  * Neither name of Kitware, Inc. nor the names of any contributors may be used
 *    to endorse or promote products derived from this software without specific
 *    prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * \file
 * \brief Format images in a way optimized for later IQR processing
 */

#ifndef VIAME_VXL_SRM_IMAGE_FORMATTER_PROCESS_H
#define VIAME_VXL_SRM_IMAGE_FORMATTER_PROCESS_H

#include <sprokit/pipeline/process.h>

#include <plugins/vxl/viame_processes_vxl_export.h>

#include <sprokit/processes/kwiver_type_traits.h>

#include <vital/types/image_container.h>
#include <vital/types/timestamp.h>

#include <memory>

namespace viame
{

namespace vxl
{

// -----------------------------------------------------------------------------
/**
 * @brief Format images in a way optimized for later IQR processing
 * 
 * Depending on parameters this operation could be perform image resizing,
 * large image tiling, and other operations. It exists mostly due to the way
 * the current GUI interface uses video-based KWA files for image storage, to
 * reduce disk usage and increase processing speeds.
 */
class VIAME_PROCESSES_VXL_NO_EXPORT vxl_srm_image_formatter_process
  : public sprokit::process
{
public:
  // -- CONSTRUCTORS --
  vxl_srm_image_formatter_process( kwiver::vital::config_block_sptr const& config );
  virtual ~vxl_srm_image_formatter_process();

protected:
  virtual void _configure();
  virtual void _step();

private:
  void make_ports();
  void make_config();

  class priv;
  const std::unique_ptr<priv> d;

}; // end class vxl_srm_image_formatter_process

} // end namespace vxl
} // end namespace viame

#endif // VIAME_VXL_SRM_IMAGE_FORMATTER_PROCESS_H
