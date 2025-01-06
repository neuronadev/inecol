module ProyectosHelper
    def enlaceMenuItem
        "<button id='dropdownSmallButton' data-dropdown-toggle='dropdownSmall' class='inline-flex items-center px-3 py-2 mb-3 me-3 text-sm font-medium text-center text-white bg-blue-700 rounded-lg md:mb-0 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800' type='button'>Archivar <svg class='w-2 h-2 ms-2' aria-hidden='true' xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 10 6'>
            <path stroke='currentColor' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 1 4 4 4-4'/>
            </svg>
            </button>

            <!-- Dropdown menu -->
            <div id='dropdownSmall' class='z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700 dark:divide-gray-600'>
                
             <ul class='py-2 text-sm text-gray-700 dark:text-gray-200' aria-labelledby='dropdownSmallButton'>
                <li>
                    <div data-action='click->organizar#archivar' data-organizar-periodo-param='2025' class='block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white' style='cursor:pointer;'>Mover a 2025</div>
                </li>
                <li>
                    <div data-action='click->organizar#archivar' data-organizar-periodo-param='2024' class='block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white' style='cursor:pointer;'>Mover a 2024</div>
                </li>
             </ul>
           </div>
        ".html_safe
    end
end
