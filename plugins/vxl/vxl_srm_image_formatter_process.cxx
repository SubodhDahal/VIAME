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
 * \brief Register multi-modal images.
 */

#include "vxl_srm_image_formatter_process.h"

#include <vital/vital_types.h>

#include <vital/types/timestamp_config.h>
#include <vital/types/image_container.h>
#include <vital/types/homography.h>

#include <sstream>
#include <iostream>
#include <list>
#include <limits>
#include <cmath>


namespace viame
{

namespace vxl
{

create_config_trait( fix_output_size, bool, "true",
  "Should the output image size always be consistent and unchanging" );

create_config_trait( resize_input, bool, "false",
  "To meet output size requirements should the image be resized or chipped" );

create_config_trait( max_image_width, unsigned, "1500",
  "Maximum allowed image width of archive after a potential resize" );
create_config_trait( max_image_height, unsigned, "1500",
  "Maximum allowed image height of archive after a potential resize" );

create_config_trait( chip_overlap, unsigned, "50",
  "If we're chipping a large image into smaller chips, this is the approximate "
  "overlap between neighboring chips" );
create_config_trait( flux_factor, double, "0.05",
  "Allowable error for resizing images to meet a more desirable size" );



//------------------------------------------------------------------------------
// Private implementation class
class vxl_srm_image_formatter_process::priv
{
public:
  priv();
  ~priv();

  bool m_fix_output_size;
  bool m_resize_input;
  unsigned m_max_image_width;
  unsigned m_max_image_height;
  unsigned m_chip_overlap;
};

// =============================================================================

vxl_srm_image_formatter_process
::vxl_srm_image_formatter_process( kwiver::vital::config_block_sptr const& config )
  : process( config ),
    d( new vxl_srm_image_formatter_process::priv() )
{
  make_ports();
  make_config();
}


vxl_srm_image_formatter_process
::~vxl_srm_image_formatter_process()
{
}


// -----------------------------------------------------------------------------
void
vxl_srm_image_formatter_process
::_configure()
{
}


// -----------------------------------------------------------------------------
void
vxl_srm_image_formatter_process
::_step()
{
}


// -----------------------------------------------------------------------------
void
vxl_srm_image_formatter_process
::make_ports()
{
}


// -----------------------------------------------------------------------------
void
vxl_srm_image_formatter_process
::make_config()
{
}


// =============================================================================
vxl_srm_image_formatter_process::priv
::priv()
{
}


vxl_srm_image_formatter_process::priv
::~priv()
{
}


} // end namespace vxl

} // end namespace viame
