<template lang="html">
    <header class="header">
        <router-link to="/feed">Assemblée Nationale</router-link>

        <div>
            <button v-on:click="logout()"><span class="material-icons">exit_to_app</span></button>
            <router-link to="/search"><span class="material-icons">search</span></router-link>
        </div>
    </header>
</template>

<script>
export default {
    methods: {
        logout(){
            this.$store.dispatch('LOG_OUT');
            this.$router.replace('search')
        }
    }
};
</script>

<style lang="scss" scoped>
    @import '../styles/vars';

    .header {
        display: flex;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        padding: 5px;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid $blue2;
        color: $white;
        z-index: 1;

        &:before {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            content: '';
            background: $glowy-bg;
            opacity: .98;
            z-index: -1;
        }

        @supports (backdrop-filter: blur(2px)) {
            -webkit-backdrop-filter: blur(2px);

            &:before {
                opacity: .94 !important;
            }
        }
    }
</style>
