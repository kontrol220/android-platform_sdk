/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Eclipse Public License, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.eclipse.org/org/documents/epl-v10.php
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.android.ide.eclipse.adt.internal.editors.layout.gle2;

import junit.framework.TestCase;

public class DomUtilitiesTest extends TestCase {

    public void testToXmlAttributeValue() throws Exception {
        assertEquals("", DomUtilities.toXmlAttributeValue(""));
        assertEquals("foo", DomUtilities.toXmlAttributeValue("foo"));
        assertEquals("foo<bar", DomUtilities.toXmlAttributeValue("foo<bar"));

        assertEquals("&quot;", DomUtilities.toXmlAttributeValue("\""));
        assertEquals("&apos;", DomUtilities.toXmlAttributeValue("'"));
        assertEquals("foo&quot;b&apos;&apos;ar",
                DomUtilities.toXmlAttributeValue("foo\"b''ar"));
    }
}