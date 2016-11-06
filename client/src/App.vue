<template>
    <div class="mdl-layout">
        <app-header></app-header>
        <main class="mdl-layout__content">
            <div class="page-content">
                <router-view></router-view>
            </div>
        </main>
    </div>
</template>

<script>
import AppHeader from './components/AppHeader.vue'

export default {
    components: {
        AppHeader
    }
};
</script>

<style lang="scss">
    @import '~normalize.css';
    @import '~material-design-lite/material.min.css';
    @import 'styles/vars';
    @import 'styles/atoms/anchors';

    body {
        font-family: 'Roboto', serif;
        font-size: 100%;
    }

    * {
        box-sizing: border-box;
    }

    p {
        line-height: 1.2em;
    }

    .material-icons {
        vertical-align: middle;
    }
</style>

<style lang="scss" scoped>
    .page-content {
        margin: 70px auto 0;
        max-width: 700px;
    }

    [class^="mdl-layout"] {
        overflow: initial;
    }
</style>
